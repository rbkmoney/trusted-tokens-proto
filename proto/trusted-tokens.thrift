namespace java com.rbkmoney.trusted.tokens
namespace erlang trusted_tokens

typedef string CardToken
typedef string CurrencySymbolicCode

exception InvalidRequest {
    1: required list<string> errors
}

struct CurrencyRef { 1: required CurrencySymbolicCode symbolic_code }

enum YearsOffset {
    current_year = 0
    one_year_offset = 1
    two_year_offset = 2
}

struct ConditionTemplateObject {
    1: required string name
    2: optional ConditionTemplate condition_template
}

struct ConditionTemplate {
    1: optional Payments payments
    2: optional Withdrawals withdrawals
}

struct Payments {
    1: required list<Condition> condition
}

struct Withdrawals {
    1: required list<Condition> condition
}

struct Condition {
    1: required CurrencyRef currency
    2: required YearsOffset years_offset
    3: optional i64 sum
    4: required i32 count
}


service TrustedTokens {

        bool IsTokenTrusted (1: ConditionTemplateObject condition_template, 2: CardToken card_token)
        throws (1: InvalidRequest ex)

        void CreateNewConditionTemplate (1: ConditionTemplateObject condition_template)
        throws (1: InvalidRequest ex)

}
