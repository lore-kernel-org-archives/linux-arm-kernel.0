From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 17 Feb 2016 08:01:53 +0800
Subject: [clk:clk-samsung-kconfig 1/2] drivers/clk/samsung/clk.h:29:26:
 error: field 'clk_data' has incomplete type
Message-ID: <201602170850.V9nmoMr3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-samsung-kconfig
head:   e83cb468452c25597e868d1ed778fa73fdaeca4c
commit: 89e08b1b13374a336dfd1d500ebc70aa545579ab [1/2] clk: samsung: Enable COMPILE_TEST for Samsung clocks
config: ia64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 89e08b1b13374a336dfd1d500ebc70aa545579ab
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/clk/samsung/clk-s3c2410.c:18:0:
>> drivers/clk/samsung/clk.h:29:26: error: field 'clk_data' has incomplete type
     struct clk_onecell_data clk_data;
                             ^
>> drivers/clk/samsung/clk.h:142:19: error: 'CLK_SET_RATE_NO_REPARENT' undeclared here (not in a function)
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                      ^
>> drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
>> drivers/clk/samsung/clk-s3c2410.c:99:2: note: in expansion of macro 'MUX'
     MUX(FCLK, "fclk", fclk_p, CLKSLOW, 4, 1),
     ^
>> drivers/clk/samsung/clk-s3c2410.c:102:29: error: array type has incomplete element type
    static struct clk_div_table divslow_d[] = {
                                ^
>> drivers/clk/samsung/clk-s3c2410.c:103:2: error: field name not in record or union initializer
     { .val = 0, .div = 1 },
     ^
   drivers/clk/samsung/clk-s3c2410.c:103:2: error: (near initialization for 'divslow_d')
>> drivers/clk/samsung/clk-s3c2410.c:103:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2410.c:103:2: error: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:104:2: error: field name not in record or union initializer
     { .val = 1, .div = 2 },
     ^
   drivers/clk/samsung/clk-s3c2410.c:104:2: error: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:104:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2410.c:104:2: error: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:105:2: error: field name not in record or union initializer
     { .val = 2, .div = 4 },
     ^
   drivers/clk/samsung/clk-s3c2410.c:105:2: error: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:105:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2410.c:105:2: error: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:106:2: error: field name not in record or union initializer
     { .val = 3, .div = 6 },
     ^
   drivers/clk/samsung/clk-s3c2410.c:106:2: error: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:106:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2410.c:106:2: error: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:107:2: error: field name not in record or union initializer
     { .val = 4, .div = 8 },
     ^
   drivers/clk/samsung/clk-s3c2410.c:107:2: error: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:107:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2410.c:107:2: error: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:108:2: error: field name not in record or union initializer
     { .val = 5, .div = 10 },
     ^
   drivers/clk/samsung/clk-s3c2410.c:108:2: error: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:108:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2410.c:108:2: error: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:109:2: error: field name not in record or union initializer
     { .val = 6, .div = 12 },
     ^
   drivers/clk/samsung/clk-s3c2410.c:109:2: error: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:109:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2410.c:109:2: error: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:110:2: error: field name not in record or union initializer
     { .val = 7, .div = 14 },
     ^
   drivers/clk/samsung/clk-s3c2410.c:110:2: error: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:110:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2410.c:110:2: error: (near initialization for 'divslow_d')
>> drivers/clk/samsung/clk-s3c2410.c:115:2: error: initializer element is not constant
     DIV_T(0, "div_slow", "xti", CLKSLOW, 0, 3, divslow_d),
     ^
   drivers/clk/samsung/clk-s3c2410.c:115:2: error: (near initialization for 's3c2410_common_dividers[0].table')
   In file included from drivers/clk/samsung/clk-s3c2410.c:18:0:
>> drivers/clk/samsung/clk-s3c2410.c:125:46: error: 'CLK_IGNORE_UNUSED' undeclared here (not in a function)
     GATE(PCLK_GPIO, "gpio", "pclk", CLKCON, 13, CLK_IGNORE_UNUSED, 0),
                                                 ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
>> drivers/clk/samsung/clk-s3c2410.c:125:2: note: in expansion of macro 'GATE'
     GATE(PCLK_GPIO, "gpio", "pclk", CLKCON, 13, CLK_IGNORE_UNUSED, 0),
     ^
   drivers/clk/samsung/clk-s3c2410.c:125:2: error: initializer element is not constant
   drivers/clk/samsung/clk-s3c2410.c:125:2: error: (near initialization for 's3c2410_common_gates[5].flags')
   In file included from drivers/clk/samsung/clk-s3c2410.c:18:0:
>> drivers/clk/samsung/clk.h:309:13: error: 'CLK_GET_RATE_NOCACHE' undeclared here (not in a function)
      .flags  = CLK_GET_RATE_NOCACHE,   \
                ^
>> drivers/clk/samsung/clk.h:317:2: note: in expansion of macro '__PLL'
     __PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE, \
     ^
>> drivers/clk/samsung/clk-s3c2410.c:197:11: note: in expansion of macro 'PLL'
     [mpll] = PLL(pll_s3c2410_mpll, MPLL, "mpll", "xti",
              ^
   drivers/clk/samsung/clk-s3c2410.c:197:2: error: initializer element is not constant
     [mpll] = PLL(pll_s3c2410_mpll, MPLL, "mpll", "xti",
     ^
   drivers/clk/samsung/clk-s3c2410.c:197:2: error: (near initialization for 's3c2410_plls[0].flags')
   drivers/clk/samsung/clk-s3c2410.c:199:2: error: initializer element is not constant
     [upll] = PLL(pll_s3c2410_upll, UPLL, "upll", "xti",
     ^
   drivers/clk/samsung/clk-s3c2410.c:199:2: error: (near initialization for 's3c2410_plls[1].flags')
   drivers/clk/samsung/clk-s3c2410.c:263:2: error: initializer element is not constant
     [mpll] = PLL(pll_s3c2440_mpll, MPLL, "mpll", "xti",
     ^
   drivers/clk/samsung/clk-s3c2410.c:263:2: error: (near initialization for 's3c244x_common_plls[0].flags')
   drivers/clk/samsung/clk-s3c2410.c:265:2: error: initializer element is not constant
     [upll] = PLL(pll_s3c2410_upll, UPLL, "upll", "xti",
     ^
   drivers/clk/samsung/clk-s3c2410.c:265:2: error: (near initialization for 's3c244x_common_plls[1].flags')
   In file included from drivers/clk/samsung/clk-s3c2410.c:18:0:
>> drivers/clk/samsung/clk.h:142:17: error: invalid operands to binary | (have 'int' and 'struct samsung_pll_clock *')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                    ^
>> drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
   drivers/clk/samsung/clk-s3c2410.c:273:2: note: in expansion of macro 'MUX'
     MUX(HCLK, "hclk", hclk_p, CLKDIVN, 1, 2),
     ^
   In file included from include/linux/io.h:23:0,
                    from include/linux/clk-provider.h:14,
                    from drivers/clk/samsung/clk-s3c2410.c:11:
>> include/linux/bug.h:33:45: error: initializer element is not constant
    #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
                                                ^
   include/linux/compiler-gcc.h:64:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                               ^
   include/linux/kernel.h:54:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^
>> drivers/clk/samsung/clk.h:141:18: note: in expansion of macro 'ARRAY_SIZE'
      .num_parents = ARRAY_SIZE(pnames),  \
                     ^
>> drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
   drivers/clk/samsung/clk-s3c2410.c:273:2: note: in expansion of macro 'MUX'
     MUX(HCLK, "hclk", hclk_p, CLKDIVN, 1, 2),
     ^
   include/linux/bug.h:33:45: error: (near initialization for 's3c244x_common_muxes[0].flags')
    #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
                                                ^
   include/linux/compiler-gcc.h:64:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                               ^
   include/linux/kernel.h:54:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^
>> drivers/clk/samsung/clk.h:141:18: note: in expansion of macro 'ARRAY_SIZE'
      .num_parents = ARRAY_SIZE(pnames),  \
                     ^
>> drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
   drivers/clk/samsung/clk-s3c2410.c:273:2: note: in expansion of macro 'MUX'
     MUX(HCLK, "hclk", hclk_p, CLKDIVN, 1, 2),
     ^
   In file included from drivers/clk/samsung/clk-s3c2410.c:18:0:
--
   In file included from drivers/clk/samsung/clk-s3c2412.c:19:0:
>> drivers/clk/samsung/clk.h:29:26: error: field 'clk_data' has incomplete type
     struct clk_onecell_data clk_data;
                             ^
>> drivers/clk/samsung/clk-s3c2412.c:89:29: error: array type has incomplete element type
    static struct clk_div_table divxti_d[] = {
                                ^
>> drivers/clk/samsung/clk-s3c2412.c:90:2: error: field name not in record or union initializer
     { .val = 0, .div = 1 },
     ^
   drivers/clk/samsung/clk-s3c2412.c:90:2: error: (near initialization for 'divxti_d')
>> drivers/clk/samsung/clk-s3c2412.c:90:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2412.c:90:2: error: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:91:2: error: field name not in record or union initializer
     { .val = 1, .div = 2 },
     ^
   drivers/clk/samsung/clk-s3c2412.c:91:2: error: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:91:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2412.c:91:2: error: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:92:2: error: field name not in record or union initializer
     { .val = 2, .div = 4 },
     ^
   drivers/clk/samsung/clk-s3c2412.c:92:2: error: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:92:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2412.c:92:2: error: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:93:2: error: field name not in record or union initializer
     { .val = 3, .div = 6 },
     ^
   drivers/clk/samsung/clk-s3c2412.c:93:2: error: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:93:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2412.c:93:2: error: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:94:2: error: field name not in record or union initializer
     { .val = 4, .div = 8 },
     ^
   drivers/clk/samsung/clk-s3c2412.c:94:2: error: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:94:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2412.c:94:2: error: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:95:2: error: field name not in record or union initializer
     { .val = 5, .div = 10 },
     ^
   drivers/clk/samsung/clk-s3c2412.c:95:2: error: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:95:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2412.c:95:2: error: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:96:2: error: field name not in record or union initializer
     { .val = 6, .div = 12 },
     ^
   drivers/clk/samsung/clk-s3c2412.c:96:2: error: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:96:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2412.c:96:2: error: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:97:2: error: field name not in record or union initializer
     { .val = 7, .div = 14 },
     ^
   drivers/clk/samsung/clk-s3c2412.c:97:2: error: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:97:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2412.c:97:2: error: (near initialization for 'divxti_d')
   In file included from drivers/clk/samsung/clk-s3c2412.c:19:0:
>> drivers/clk/samsung/clk-s3c2412.c:114:38: error: 'CLK_SET_RATE_PARENT' undeclared here (not in a function)
     FFACTOR(0, "ff_hclk", "hclk", 2, 1, CLK_SET_RATE_PARENT),
                                         ^
   drivers/clk/samsung/clk.h:104:13: note: in definition of macro 'FFACTOR'
      .flags  = f,   \
                ^
>> drivers/clk/samsung/clk-s3c2412.c:114:2: error: initializer element is not constant
     FFACTOR(0, "ff_hclk", "hclk", 2, 1, CLK_SET_RATE_PARENT),
     ^
   drivers/clk/samsung/clk-s3c2412.c:114:2: error: (near initialization for 's3c2412_ffactor[0].flags')
   In file included from drivers/clk/samsung/clk-s3c2412.c:19:0:
>> drivers/clk/samsung/clk.h:142:19: error: 'CLK_SET_RATE_NO_REPARENT' undeclared here (not in a function)
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                      ^
>> drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
>> drivers/clk/samsung/clk-s3c2412.c:134:2: note: in expansion of macro 'MUX'
     MUX(0, "erefclk", erefclk_p, CLKSRC, 14, 2),
     ^
>> drivers/clk/samsung/clk.h:142:17: error: invalid operands to binary | (have 'int' and 'struct samsung_fixed_factor_clock *')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                    ^
>> drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
>> drivers/clk/samsung/clk-s3c2412.c:134:2: note: in expansion of macro 'MUX'
     MUX(0, "erefclk", erefclk_p, CLKSRC, 14, 2),
     ^
   In file included from include/linux/io.h:23:0,
                    from include/linux/clk-provider.h:14,
                    from drivers/clk/samsung/clk-s3c2412.c:11:
>> include/linux/bug.h:33:45: error: initializer element is not constant
    #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
                                                ^
   include/linux/compiler-gcc.h:64:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                               ^
   include/linux/kernel.h:54:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^
>> drivers/clk/samsung/clk.h:141:18: note: in expansion of macro 'ARRAY_SIZE'
      .num_parents = ARRAY_SIZE(pnames),  \
                     ^
>> drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
>> drivers/clk/samsung/clk-s3c2412.c:134:2: note: in expansion of macro 'MUX'
     MUX(0, "erefclk", erefclk_p, CLKSRC, 14, 2),
     ^
   include/linux/bug.h:33:45: error: (near initialization for 's3c2412_muxes[0].flags')
    #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
                                                ^
   include/linux/compiler-gcc.h:64:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                               ^
   include/linux/kernel.h:54:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^
>> drivers/clk/samsung/clk.h:141:18: note: in expansion of macro 'ARRAY_SIZE'
      .num_parents = ARRAY_SIZE(pnames),  \
                     ^
>> drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
>> drivers/clk/samsung/clk-s3c2412.c:134:2: note: in expansion of macro 'MUX'
     MUX(0, "erefclk", erefclk_p, CLKSRC, 14, 2),
     ^
   In file included from drivers/clk/samsung/clk-s3c2412.c:19:0:
>> drivers/clk/samsung/clk.h:142:17: error: invalid operands to binary | (have 'int' and 'struct samsung_fixed_factor_clock *')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                    ^
--
   In file included from drivers/clk/samsung/clk-s3c2443.c:19:0:
>> drivers/clk/samsung/clk.h:29:26: error: field 'clk_data' has incomplete type
     struct clk_onecell_data clk_data;
                             ^
>> drivers/clk/samsung/clk.h:142:19: error: 'CLK_SET_RATE_NO_REPARENT' undeclared here (not in a function)
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                      ^
>> drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
>> drivers/clk/samsung/clk-s3c2443.c:117:2: note: in expansion of macro 'MUX'
     MUX(0, "epllref", epllref_p, CLKSRC, 7, 2),
     ^
>> drivers/clk/samsung/clk-s3c2443.c:125:29: error: array type has incomplete element type
    static struct clk_div_table hclk_d[] = {
                                ^
>> drivers/clk/samsung/clk-s3c2443.c:126:2: error: field name not in record or union initializer
     { .val = 0, .div = 1 },
     ^
   drivers/clk/samsung/clk-s3c2443.c:126:2: error: (near initialization for 'hclk_d')
>> drivers/clk/samsung/clk-s3c2443.c:126:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2443.c:126:2: error: (near initialization for 'hclk_d')
   drivers/clk/samsung/clk-s3c2443.c:127:2: error: field name not in record or union initializer
     { .val = 1, .div = 2 },
     ^
   drivers/clk/samsung/clk-s3c2443.c:127:2: error: (near initialization for 'hclk_d')
   drivers/clk/samsung/clk-s3c2443.c:127:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2443.c:127:2: error: (near initialization for 'hclk_d')
   drivers/clk/samsung/clk-s3c2443.c:128:2: error: field name not in record or union initializer
     { .val = 3, .div = 4 },
     ^
   drivers/clk/samsung/clk-s3c2443.c:128:2: error: (near initialization for 'hclk_d')
   drivers/clk/samsung/clk-s3c2443.c:128:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2443.c:128:2: error: (near initialization for 'hclk_d')
   drivers/clk/samsung/clk-s3c2443.c:132:29: error: array type has incomplete element type
    static struct clk_div_table mdivclk_d[] = {
                                ^
   drivers/clk/samsung/clk-s3c2443.c:133:2: error: field name not in record or union initializer
     { .val = 0, .div = 1 },
     ^
   drivers/clk/samsung/clk-s3c2443.c:133:2: error: (near initialization for 'mdivclk_d')
   drivers/clk/samsung/clk-s3c2443.c:133:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2443.c:133:2: error: (near initialization for 'mdivclk_d')
   drivers/clk/samsung/clk-s3c2443.c:134:2: error: field name not in record or union initializer
     { .val = 1, .div = 3 },
     ^
   drivers/clk/samsung/clk-s3c2443.c:134:2: error: (near initialization for 'mdivclk_d')
   drivers/clk/samsung/clk-s3c2443.c:134:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2443.c:134:2: error: (near initialization for 'mdivclk_d')
   drivers/clk/samsung/clk-s3c2443.c:135:2: error: field name not in record or union initializer
     { .val = 2, .div = 5 },
     ^
   drivers/clk/samsung/clk-s3c2443.c:135:2: error: (near initialization for 'mdivclk_d')
   drivers/clk/samsung/clk-s3c2443.c:135:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2443.c:135:2: error: (near initialization for 'mdivclk_d')
   drivers/clk/samsung/clk-s3c2443.c:136:2: error: field name not in record or union initializer
     { .val = 3, .div = 7 },
     ^
   drivers/clk/samsung/clk-s3c2443.c:136:2: error: (near initialization for 'mdivclk_d')
   drivers/clk/samsung/clk-s3c2443.c:136:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2443.c:136:2: error: (near initialization for 'mdivclk_d')
   drivers/clk/samsung/clk-s3c2443.c:137:2: error: field name not in record or union initializer
     { .val = 4, .div = 9 },
     ^
   drivers/clk/samsung/clk-s3c2443.c:137:2: error: (near initialization for 'mdivclk_d')
   drivers/clk/samsung/clk-s3c2443.c:137:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2443.c:137:2: error: (near initialization for 'mdivclk_d')
   drivers/clk/samsung/clk-s3c2443.c:138:2: error: field name not in record or union initializer
     { .val = 5, .div = 11 },
     ^
   drivers/clk/samsung/clk-s3c2443.c:138:2: error: (near initialization for 'mdivclk_d')
   drivers/clk/samsung/clk-s3c2443.c:138:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2443.c:138:2: error: (near initialization for 'mdivclk_d')
   drivers/clk/samsung/clk-s3c2443.c:139:2: error: field name not in record or union initializer
     { .val = 6, .div = 13 },
     ^
   drivers/clk/samsung/clk-s3c2443.c:139:2: error: (near initialization for 'mdivclk_d')
   drivers/clk/samsung/clk-s3c2443.c:139:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2443.c:139:2: error: (near initialization for 'mdivclk_d')
   drivers/clk/samsung/clk-s3c2443.c:140:2: error: field name not in record or union initializer
     { .val = 7, .div = 15 },
     ^
   drivers/clk/samsung/clk-s3c2443.c:140:2: error: (near initialization for 'mdivclk_d')
   drivers/clk/samsung/clk-s3c2443.c:140:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2443.c:140:2: error: (near initialization for 'mdivclk_d')
>> drivers/clk/samsung/clk-s3c2443.c:145:2: error: initializer element is not constant
     DIV_T(0, "mdivclk", "xti", CLKDIV0, 6, 3, mdivclk_d),
     ^
   drivers/clk/samsung/clk-s3c2443.c:145:2: error: (near initialization for 's3c2443_common_dividers[0].table')
   drivers/clk/samsung/clk-s3c2443.c:147:2: error: initializer element is not constant
     DIV_T(HCLK, "hclk", "prediv", CLKDIV0, 0, 2, hclk_d),
     ^
   drivers/clk/samsung/clk-s3c2443.c:147:2: error: (near initialization for 's3c2443_common_dividers[2].table')
   In file included from drivers/clk/samsung/clk-s3c2443.c:19:0:
>> drivers/clk/samsung/clk-s3c2443.c:164:47: error: 'CLK_IGNORE_UNUSED' undeclared here (not in a function)
     GATE(HCLK_DRAM, "dram", "hclk", HCLKCON, 19, CLK_IGNORE_UNUSED, 0),
                                                  ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
>> drivers/clk/samsung/clk-s3c2443.c:164:2: note: in expansion of macro 'GATE'
     GATE(HCLK_DRAM, "dram", "hclk", HCLKCON, 19, CLK_IGNORE_UNUSED, 0),
     ^
   drivers/clk/samsung/clk-s3c2443.c:164:2: error: initializer element is not constant
   drivers/clk/samsung/clk-s3c2443.c:164:2: error: (near initialization for 's3c2443_common_gates[6].flags')
   drivers/clk/samsung/clk-s3c2443.c:165:2: error: initializer element is not constant
     GATE(HCLK_SSMC, "ssmc", "hclk", HCLKCON, 18, CLK_IGNORE_UNUSED, 0),
     ^
   drivers/clk/samsung/clk-s3c2443.c:165:2: error: (near initialization for 's3c2443_common_gates[7].flags')
   drivers/clk/samsung/clk-s3c2443.c:170:2: error: initializer element is not constant
     GATE(HCLK_DMA5, "dma5", "hclk", HCLKCON, 5, CLK_IGNORE_UNUSED, 0),
     ^
   drivers/clk/samsung/clk-s3c2443.c:170:2: error: (near initialization for 's3c2443_common_gates[12].flags')
   drivers/clk/samsung/clk-s3c2443.c:171:2: error: initializer element is not constant
     GATE(HCLK_DMA4, "dma4", "hclk", HCLKCON, 4, CLK_IGNORE_UNUSED, 0),
     ^
   drivers/clk/samsung/clk-s3c2443.c:171:2: error: (near initialization for 's3c2443_common_gates[13].flags')
   drivers/clk/samsung/clk-s3c2443.c:172:2: error: initializer element is not constant
     GATE(HCLK_DMA3, "dma3", "hclk", HCLKCON, 3, CLK_IGNORE_UNUSED, 0),
     ^
   drivers/clk/samsung/clk-s3c2443.c:172:2: error: (near initialization for 's3c2443_common_gates[14].flags')
   drivers/clk/samsung/clk-s3c2443.c:173:2: error: initializer element is not constant
     GATE(HCLK_DMA2, "dma2", "hclk", HCLKCON, 2, CLK_IGNORE_UNUSED, 0),
     ^
   drivers/clk/samsung/clk-s3c2443.c:173:2: error: (near initialization for 's3c2443_common_gates[15].flags')
   drivers/clk/samsung/clk-s3c2443.c:174:2: error: initializer element is not constant
     GATE(HCLK_DMA1, "dma1", "hclk", HCLKCON, 1, CLK_IGNORE_UNUSED, 0),
     ^
   drivers/clk/samsung/clk-s3c2443.c:174:2: error: (near initialization for 's3c2443_common_gates[16].flags')
   drivers/clk/samsung/clk-s3c2443.c:175:2: error: initializer element is not constant
     GATE(HCLK_DMA0, "dma0", "hclk", HCLKCON, 0, CLK_IGNORE_UNUSED, 0),
     ^
   drivers/clk/samsung/clk-s3c2443.c:175:2: error: (near initialization for 's3c2443_common_gates[17].flags')
   drivers/clk/samsung/clk-s3c2443.c:176:2: error: initializer element is not constant
     GATE(PCLK_GPIO, "gpio", "pclk", PCLKCON, 13, CLK_IGNORE_UNUSED, 0),
     ^
   drivers/clk/samsung/clk-s3c2443.c:176:2: error: (near initialization for 's3c2443_common_gates[18].flags')
   In file included from drivers/clk/samsung/clk-s3c2443.c:19:0:
>> drivers/clk/samsung/clk.h:309:13: error: 'CLK_GET_RATE_NOCACHE' undeclared here (not in a function)
      .flags  = CLK_GET_RATE_NOCACHE,   \
                ^
>> drivers/clk/samsung/clk.h:317:2: note: in expansion of macro '__PLL'
     __PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE, \
     ^
>> drivers/clk/samsung/clk-s3c2443.c:224:11: note: in expansion of macro 'PLL'
     [mpll] = PLL(pll_6552_s3c2416, 0, "mpll", "mpllref",
              ^
   drivers/clk/samsung/clk-s3c2443.c:224:2: error: initializer element is not constant
     [mpll] = PLL(pll_6552_s3c2416, 0, "mpll", "mpllref",
     ^
   drivers/clk/samsung/clk-s3c2443.c:224:2: error: (near initialization for 's3c2416_pll_clks[0].flags')
   drivers/clk/samsung/clk-s3c2443.c:226:2: error: initializer element is not constant
     [epll] = PLL(pll_6553, 0, "epll", "epllref",
     ^
   drivers/clk/samsung/clk-s3c2443.c:226:2: error: (near initialization for 's3c2416_pll_clks[1].flags')
   drivers/clk/samsung/clk-s3c2443.c:234:29: error: array type has incomplete element type
    static struct clk_div_table armdiv_s3c2416_d[] = {
                                ^
   drivers/clk/samsung/clk-s3c2443.c:235:2: error: field name not in record or union initializer
     { .val = 0, .div = 1 },
     ^
   drivers/clk/samsung/clk-s3c2443.c:235:2: error: (near initialization for 'armdiv_s3c2416_d')
   drivers/clk/samsung/clk-s3c2443.c:235:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2443.c:235:2: error: (near initialization for 'armdiv_s3c2416_d')
   drivers/clk/samsung/clk-s3c2443.c:236:2: error: field name not in record or union initializer
     { .val = 1, .div = 2 },
     ^
   drivers/clk/samsung/clk-s3c2443.c:236:2: error: (near initialization for 'armdiv_s3c2416_d')
   drivers/clk/samsung/clk-s3c2443.c:236:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2443.c:236:2: error: (near initialization for 'armdiv_s3c2416_d')
   drivers/clk/samsung/clk-s3c2443.c:237:2: error: field name not in record or union initializer
     { .val = 2, .div = 3 },
     ^
   drivers/clk/samsung/clk-s3c2443.c:237:2: error: (near initialization for 'armdiv_s3c2416_d')
   drivers/clk/samsung/clk-s3c2443.c:237:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2443.c:237:2: error: (near initialization for 'armdiv_s3c2416_d')
   drivers/clk/samsung/clk-s3c2443.c:238:2: error: field name not in record or union initializer
     { .val = 3, .div = 4 },
     ^
   drivers/clk/samsung/clk-s3c2443.c:238:2: error: (near initialization for 'armdiv_s3c2416_d')
   drivers/clk/samsung/clk-s3c2443.c:238:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2443.c:238:2: error: (near initialization for 'armdiv_s3c2416_d')
   drivers/clk/samsung/clk-s3c2443.c:239:2: error: field name not in record or union initializer
     { .val = 5, .div = 6 },
     ^
   drivers/clk/samsung/clk-s3c2443.c:239:2: error: (near initialization for 'armdiv_s3c2416_d')
   drivers/clk/samsung/clk-s3c2443.c:239:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2443.c:239:2: error: (near initialization for 'armdiv_s3c2416_d')
   drivers/clk/samsung/clk-s3c2443.c:240:2: error: field name not in record or union initializer
     { .val = 7, .div = 8 },
     ^
   drivers/clk/samsung/clk-s3c2443.c:240:2: error: (near initialization for 'armdiv_s3c2416_d')
   drivers/clk/samsung/clk-s3c2443.c:240:2: error: field name not in record or union initializer
   drivers/clk/samsung/clk-s3c2443.c:240:2: error: (near initialization for 'armdiv_s3c2416_d')
   drivers/clk/samsung/clk-s3c2443.c:245:2: error: initializer element is not constant
     DIV_T(ARMDIV, "armdiv", "msysclk", CLKDIV0, 9, 3, armdiv_s3c2416_d),
     ^
   drivers/clk/samsung/clk-s3c2443.c:245:2: error: (near initialization for 's3c2416_dividers[0].table')
   In file included from drivers/clk/samsung/clk-s3c2443.c:19:0:
>> drivers/clk/samsung/clk.h:142:17: error: invalid operands to binary | (have 'int' and 'struct samsung_div_clock *')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                    ^
>> drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
   drivers/clk/samsung/clk-s3c2443.c:251:2: note: in expansion of macro 'MUX'
     MUX(MUX_HSMMC0, "mux_hsmmc0", s3c2416_hsmmc0_p, CLKSRC, 16, 1),
     ^
   In file included from include/linux/io.h:23:0,
                    from include/linux/clk-provider.h:14,
                    from drivers/clk/samsung/clk-s3c2443.c:11:
>> include/linux/bug.h:33:45: error: initializer element is not constant
    #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
                                                ^
   include/linux/compiler-gcc.h:64:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                               ^
   include/linux/kernel.h:54:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^
>> drivers/clk/samsung/clk.h:141:18: note: in expansion of macro 'ARRAY_SIZE'
      .num_parents = ARRAY_SIZE(pnames),  \
                     ^
>> drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
   drivers/clk/samsung/clk-s3c2443.c:251:2: note: in expansion of macro 'MUX'
     MUX(MUX_HSMMC0, "mux_hsmmc0", s3c2416_hsmmc0_p, CLKSRC, 16, 1),
     ^
   include/linux/bug.h:33:45: error: (near initialization for 's3c2416_muxes[0].flags')
    #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
                                                ^
   include/linux/compiler-gcc.h:64:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                               ^
   include/linux/kernel.h:54:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^
>> drivers/clk/samsung/clk.h:141:18: note: in expansion of macro 'ARRAY_SIZE'
      .num_parents = ARRAY_SIZE(pnames),  \
                     ^
>> drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
   drivers/clk/samsung/clk-s3c2443.c:251:2: note: in expansion of macro 'MUX'
     MUX(MUX_HSMMC0, "mux_hsmmc0", s3c2416_hsmmc0_p, CLKSRC, 16, 1),
     ^
   In file included from drivers/clk/samsung/clk-s3c2443.c:19:0:

vim +/clk_data +29 drivers/clk/samsung/clk.h

976face4 Rahul Sharma     2014-03-12   23   * @reg_base: virtual address for the register base.
976face4 Rahul Sharma     2014-03-12   24   * @clk_data: holds clock related data like clk* and number of clocks.
2e41b9fc Pankaj Dubey     2014-09-29   25   * @lock: maintains exclusion between callbacks for a given clock-provider.
976face4 Rahul Sharma     2014-03-12   26   */
976face4 Rahul Sharma     2014-03-12   27  struct samsung_clk_provider {
976face4 Rahul Sharma     2014-03-12   28  	void __iomem *reg_base;
976face4 Rahul Sharma     2014-03-12  @29  	struct clk_onecell_data clk_data;
976face4 Rahul Sharma     2014-03-12   30  	spinlock_t lock;
976face4 Rahul Sharma     2014-03-12   31  };
976face4 Rahul Sharma     2014-03-12   32  
976face4 Rahul Sharma     2014-03-12   33  /**
5e2e0195 Heiko Stuebner   2013-03-18   34   * struct samsung_clock_alias: information about mux clock
5e2e0195 Heiko Stuebner   2013-03-18   35   * @id: platform specific id of the clock.
5e2e0195 Heiko Stuebner   2013-03-18   36   * @dev_name: name of the device to which this clock belongs.
5e2e0195 Heiko Stuebner   2013-03-18   37   * @alias: optional clock alias name to be assigned to this clock.
5e2e0195 Heiko Stuebner   2013-03-18   38   */
5e2e0195 Heiko Stuebner   2013-03-18   39  struct samsung_clock_alias {
5e2e0195 Heiko Stuebner   2013-03-18   40  	unsigned int		id;
5e2e0195 Heiko Stuebner   2013-03-18   41  	const char		*dev_name;
5e2e0195 Heiko Stuebner   2013-03-18   42  	const char		*alias;
5e2e0195 Heiko Stuebner   2013-03-18   43  };
5e2e0195 Heiko Stuebner   2013-03-18   44  
5e2e0195 Heiko Stuebner   2013-03-18   45  #define ALIAS(_id, dname, a)	\
5e2e0195 Heiko Stuebner   2013-03-18   46  	{							\
5e2e0195 Heiko Stuebner   2013-03-18   47  		.id		= _id,				\
5e2e0195 Heiko Stuebner   2013-03-18   48  		.dev_name	= dname,			\
5e2e0195 Heiko Stuebner   2013-03-18   49  		.alias		= a,				\
5e2e0195 Heiko Stuebner   2013-03-18   50  	}
5e2e0195 Heiko Stuebner   2013-03-18   51  
d2127ac4 Vikas Sajjan     2013-06-11   52  #define MHZ (1000 * 1000)
d2127ac4 Vikas Sajjan     2013-06-11   53  
5e2e0195 Heiko Stuebner   2013-03-18   54  /**
721c42a3 Thomas Abraham   2013-03-09   55   * struct samsung_fixed_rate_clock: information about fixed-rate clock
721c42a3 Thomas Abraham   2013-03-09   56   * @id: platform specific id of the clock.
721c42a3 Thomas Abraham   2013-03-09   57   * @name: name of this fixed-rate clock.
721c42a3 Thomas Abraham   2013-03-09   58   * @parent_name: optional parent clock name.
721c42a3 Thomas Abraham   2013-03-09   59   * @flags: optional fixed-rate clock flags.
721c42a3 Thomas Abraham   2013-03-09   60   * @fixed-rate: fixed clock rate of this clock.
721c42a3 Thomas Abraham   2013-03-09   61   */
721c42a3 Thomas Abraham   2013-03-09   62  struct samsung_fixed_rate_clock {
721c42a3 Thomas Abraham   2013-03-09   63  	unsigned int		id;
721c42a3 Thomas Abraham   2013-03-09   64  	char			*name;
721c42a3 Thomas Abraham   2013-03-09   65  	const char		*parent_name;
721c42a3 Thomas Abraham   2013-03-09   66  	unsigned long		flags;
721c42a3 Thomas Abraham   2013-03-09   67  	unsigned long		fixed_rate;
721c42a3 Thomas Abraham   2013-03-09   68  };
721c42a3 Thomas Abraham   2013-03-09   69  
721c42a3 Thomas Abraham   2013-03-09   70  #define FRATE(_id, cname, pname, f, frate)		\
721c42a3 Thomas Abraham   2013-03-09   71  	{						\
721c42a3 Thomas Abraham   2013-03-09   72  		.id		= _id,			\
721c42a3 Thomas Abraham   2013-03-09   73  		.name		= cname,		\
721c42a3 Thomas Abraham   2013-03-09   74  		.parent_name	= pname,		\
721c42a3 Thomas Abraham   2013-03-09   75  		.flags		= f,			\
721c42a3 Thomas Abraham   2013-03-09   76  		.fixed_rate	= frate,		\
721c42a3 Thomas Abraham   2013-03-09   77  	}
721c42a3 Thomas Abraham   2013-03-09   78  
721c42a3 Thomas Abraham   2013-03-09   79  /*
721c42a3 Thomas Abraham   2013-03-09   80   * struct samsung_fixed_factor_clock: information about fixed-factor clock
721c42a3 Thomas Abraham   2013-03-09   81   * @id: platform specific id of the clock.
721c42a3 Thomas Abraham   2013-03-09   82   * @name: name of this fixed-factor clock.
721c42a3 Thomas Abraham   2013-03-09   83   * @parent_name: parent clock name.
721c42a3 Thomas Abraham   2013-03-09   84   * @mult: fixed multiplication factor.
721c42a3 Thomas Abraham   2013-03-09   85   * @div: fixed division factor.
721c42a3 Thomas Abraham   2013-03-09   86   * @flags: optional fixed-factor clock flags.
721c42a3 Thomas Abraham   2013-03-09   87   */
721c42a3 Thomas Abraham   2013-03-09   88  struct samsung_fixed_factor_clock {
721c42a3 Thomas Abraham   2013-03-09   89  	unsigned int		id;
721c42a3 Thomas Abraham   2013-03-09   90  	char			*name;
721c42a3 Thomas Abraham   2013-03-09   91  	const char		*parent_name;
721c42a3 Thomas Abraham   2013-03-09   92  	unsigned long		mult;
721c42a3 Thomas Abraham   2013-03-09   93  	unsigned long		div;
721c42a3 Thomas Abraham   2013-03-09   94  	unsigned long		flags;
721c42a3 Thomas Abraham   2013-03-09   95  };
721c42a3 Thomas Abraham   2013-03-09   96  
721c42a3 Thomas Abraham   2013-03-09   97  #define FFACTOR(_id, cname, pname, m, d, f)		\
721c42a3 Thomas Abraham   2013-03-09   98  	{						\
721c42a3 Thomas Abraham   2013-03-09   99  		.id		= _id,			\
721c42a3 Thomas Abraham   2013-03-09  100  		.name		= cname,		\
721c42a3 Thomas Abraham   2013-03-09  101  		.parent_name	= pname,		\
721c42a3 Thomas Abraham   2013-03-09  102  		.mult		= m,			\
721c42a3 Thomas Abraham   2013-03-09  103  		.div		= d,			\
721c42a3 Thomas Abraham   2013-03-09  104  		.flags		= f,			\
721c42a3 Thomas Abraham   2013-03-09  105  	}
721c42a3 Thomas Abraham   2013-03-09  106  
721c42a3 Thomas Abraham   2013-03-09  107  /**
721c42a3 Thomas Abraham   2013-03-09  108   * struct samsung_mux_clock: information about mux clock
721c42a3 Thomas Abraham   2013-03-09  109   * @id: platform specific id of the clock.
721c42a3 Thomas Abraham   2013-03-09  110   * @dev_name: name of the device to which this clock belongs.
721c42a3 Thomas Abraham   2013-03-09  111   * @name: name of this mux clock.
721c42a3 Thomas Abraham   2013-03-09  112   * @parent_names: array of pointer to parent clock names.
721c42a3 Thomas Abraham   2013-03-09  113   * @num_parents: number of parents listed in @parent_names.
721c42a3 Thomas Abraham   2013-03-09  114   * @flags: optional flags for basic clock.
721c42a3 Thomas Abraham   2013-03-09  115   * @offset: offset of the register for configuring the mux.
721c42a3 Thomas Abraham   2013-03-09  116   * @shift: starting bit location of the mux control bit-field in @reg.
721c42a3 Thomas Abraham   2013-03-09  117   * @width: width of the mux control bit-field in @reg.
721c42a3 Thomas Abraham   2013-03-09  118   * @mux_flags: flags for mux-type clock.
721c42a3 Thomas Abraham   2013-03-09  119   * @alias: optional clock alias name to be assigned to this clock.
721c42a3 Thomas Abraham   2013-03-09  120   */
721c42a3 Thomas Abraham   2013-03-09  121  struct samsung_mux_clock {
721c42a3 Thomas Abraham   2013-03-09  122  	unsigned int		id;
721c42a3 Thomas Abraham   2013-03-09  123  	const char		*dev_name;
721c42a3 Thomas Abraham   2013-03-09  124  	const char		*name;
4a1caed3 Uwe Kleine-K?nig 2015-05-28  125  	const char		*const *parent_names;
721c42a3 Thomas Abraham   2013-03-09  126  	u8			num_parents;
721c42a3 Thomas Abraham   2013-03-09  127  	unsigned long		flags;
721c42a3 Thomas Abraham   2013-03-09  128  	unsigned long		offset;
721c42a3 Thomas Abraham   2013-03-09  129  	u8			shift;
721c42a3 Thomas Abraham   2013-03-09  130  	u8			width;
721c42a3 Thomas Abraham   2013-03-09  131  	u8			mux_flags;
721c42a3 Thomas Abraham   2013-03-09  132  	const char		*alias;
721c42a3 Thomas Abraham   2013-03-09  133  };
721c42a3 Thomas Abraham   2013-03-09  134  
721c42a3 Thomas Abraham   2013-03-09  135  #define __MUX(_id, dname, cname, pnames, o, s, w, f, mf, a)	\
721c42a3 Thomas Abraham   2013-03-09  136  	{							\
721c42a3 Thomas Abraham   2013-03-09  137  		.id		= _id,				\
721c42a3 Thomas Abraham   2013-03-09  138  		.dev_name	= dname,			\
721c42a3 Thomas Abraham   2013-03-09  139  		.name		= cname,			\
721c42a3 Thomas Abraham   2013-03-09  140  		.parent_names	= pnames,			\
721c42a3 Thomas Abraham   2013-03-09 @141  		.num_parents	= ARRAY_SIZE(pnames),		\
819c1de3 James Hogan      2013-07-29 @142  		.flags		= (f) | CLK_SET_RATE_NO_REPARENT, \
721c42a3 Thomas Abraham   2013-03-09  143  		.offset		= o,				\
721c42a3 Thomas Abraham   2013-03-09  144  		.shift		= s,				\
721c42a3 Thomas Abraham   2013-03-09  145  		.width		= w,				\
721c42a3 Thomas Abraham   2013-03-09  146  		.mux_flags	= mf,				\
721c42a3 Thomas Abraham   2013-03-09  147  		.alias		= a,				\
721c42a3 Thomas Abraham   2013-03-09  148  	}
721c42a3 Thomas Abraham   2013-03-09  149  
721c42a3 Thomas Abraham   2013-03-09  150  #define MUX(_id, cname, pnames, o, s, w)			\
721c42a3 Thomas Abraham   2013-03-09 @151  	__MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
721c42a3 Thomas Abraham   2013-03-09  152  
721c42a3 Thomas Abraham   2013-03-09  153  #define MUX_A(_id, cname, pnames, o, s, w, a)			\
721c42a3 Thomas Abraham   2013-03-09  154  	__MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, a)

:::::: The code at line 29 was first introduced by commit
:::::: 976face4b46ab36b04312b4e404d160296716d46 clk/samsung: add support for multiple clock providers

:::::: TO: Rahul Sharma <rahul.sharma@samsung.com>
:::::: CC: Tomasz Figa <t.figa@samsung.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 42298 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160217/62a9e6f7/attachment-0001.obj>
