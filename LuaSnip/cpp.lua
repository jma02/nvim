local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local r = require("luasnip.extras").rep

ls.add_snippets(cpp, {
  cpp = {
        s({
            trig = "for",
            namr = "For loop (competitive programming)",
            dscr = "Iterates over n",
        }, {
            t({"for(int i = 0; i < n; i++){", 
            "\t"}),
            i(1),
            t({"",
            "}"})
        }),
        s({
            trig = "comp",
            namr = "Comparator lambda function",
            dscr = "For sorting stuff",
        }, {
            t({"auto cmp = [&](pair<int,int> const& a, pair<int,int> const& b) {",
            "\treturn a.second < b.second;",
            "};"
            })
          }),
        s({
            trig = "vi",
            namr = "vector<int>",
            dscr = "vector<int>",
        }, {
            t("vector<int> "),
            i(1)
        }),
        s({
          trig = "mat",
          namr = "vector<vector<int>>",
        },
        {
          t("vector<vector<int>> mat(n, vector<int>(m,0));"),
          i(1)
        }),
        s({
          trig = "debug_vec",
          namr = "template for debugging a vector or anything reasonably iterable",
        },
        {
          t({"template<typename Ostream, typename Cont>",
"enable_if_t<is_same_v<Ostream,ostream>, Ostream&> operator<<(Ostream& os, const Cont& v){",
    '\tos<<"[";',
    '\tfor(auto& x:v){os<<x<<", ";}',
    '\treturn os<<"]";',
        "}",
        }),
      }),
        s({
            trig = "combo",
            namr = "combinatorics namespace",
            dscr = "Functions for combinatorics (competitive programming)",
        }, {
            t({"namespace Combo{",
            "\tvector<ll> fact = {1};",
            "\tvector<ll> inv = {1};",
            "",
            "\tll binexp(ll a, ll b){",
            "\t\tif (b == 0) return 1ll;",
            "\t\tif (b == 1) return a % MOD;",
            "\t\tif (b % 2) return (a * binexp(a, b - 1)) % MOD;",
            "\t\treturn binexp((a*a)%MOD, b/2);",
            "\t}",
            "",
            "\tll f(ll a){",
            "\t\twhile (fact.size() <= a)",
            "\t\t\tfact.push_back(((ll)fact.size() * fact.back()) % MOD);",
            "\t\treturn fact[a];",
            "\t}",
            "",
            "\tll i(ll b){",
            "\t\twhile (inv.size() <= b)",
            "\t\t\tinv.push_back((inv.back() * binexp(inv.size(), MOD-2)) % MOD);",
            "\t\treturn inv[b];",
            "\t}",
            "",
            "\tll choose(ll a, ll b){",
            "\t\tif (a < b) return 0;",
            "",
            "\t\tll res = (f(a) * i(b)) % MOD;",
            "\t\tres *= i(a - b); res %= MOD;",
            "\t\treturn res;",
            "\t}",
            "};",
            }),
        }),
    }, 
})
