From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 17 Feb 2016 10:47:08 +0800
Subject: [clk:clk-samsung-kconfig 1/2]
 drivers/clk/samsung/clk-s3c2410.c:102:29: error: array type has incomplete
 element type 'struct clk_div_table'
Message-ID: <201602171005.yH78bWkA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-samsung-kconfig
head:   e83cb468452c25597e868d1ed778fa73fdaeca4c
commit: 89e08b1b13374a336dfd1d500ebc70aa545579ab [1/2] clk: samsung: Enable COMPILE_TEST for Samsung clocks
config: mips-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 89e08b1b13374a336dfd1d500ebc70aa545579ab
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/clk/samsung/clk-s3c2410.c:18:0:
   drivers/clk/samsung/clk.h:29:26: error: field 'clk_data' has incomplete type
     struct clk_onecell_data clk_data;
                             ^
   drivers/clk/samsung/clk.h:142:19: error: 'CLK_SET_RATE_NO_REPARENT' undeclared here (not in a function)
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                      ^
   drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
   drivers/clk/samsung/clk-s3c2410.c:99:2: note: in expansion of macro 'MUX'
     MUX(FCLK, "fclk", fclk_p, CLKSLOW, 4, 1),
     ^
>> drivers/clk/samsung/clk-s3c2410.c:102:29: error: array type has incomplete element type 'struct clk_div_table'
    static struct clk_div_table divslow_d[] = {
                                ^
   drivers/clk/samsung/clk-s3c2410.c:103:4: error: field name not in record or union initializer
     { .val = 0, .div = 1 },
       ^
   drivers/clk/samsung/clk-s3c2410.c:103:4: note: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:103:14: error: field name not in record or union initializer
     { .val = 0, .div = 1 },
                 ^
   drivers/clk/samsung/clk-s3c2410.c:103:14: note: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:104:4: error: field name not in record or union initializer
     { .val = 1, .div = 2 },
       ^
   drivers/clk/samsung/clk-s3c2410.c:104:4: note: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:104:14: error: field name not in record or union initializer
     { .val = 1, .div = 2 },
                 ^
   drivers/clk/samsung/clk-s3c2410.c:104:14: note: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:105:4: error: field name not in record or union initializer
     { .val = 2, .div = 4 },
       ^
   drivers/clk/samsung/clk-s3c2410.c:105:4: note: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:105:14: error: field name not in record or union initializer
     { .val = 2, .div = 4 },
                 ^
   drivers/clk/samsung/clk-s3c2410.c:105:14: note: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:106:4: error: field name not in record or union initializer
     { .val = 3, .div = 6 },
       ^
   drivers/clk/samsung/clk-s3c2410.c:106:4: note: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:106:14: error: field name not in record or union initializer
     { .val = 3, .div = 6 },
                 ^
   drivers/clk/samsung/clk-s3c2410.c:106:14: note: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:107:4: error: field name not in record or union initializer
     { .val = 4, .div = 8 },
       ^
   drivers/clk/samsung/clk-s3c2410.c:107:4: note: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:107:14: error: field name not in record or union initializer
     { .val = 4, .div = 8 },
                 ^
   drivers/clk/samsung/clk-s3c2410.c:107:14: note: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:108:4: error: field name not in record or union initializer
     { .val = 5, .div = 10 },
       ^
   drivers/clk/samsung/clk-s3c2410.c:108:4: note: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:108:14: error: field name not in record or union initializer
     { .val = 5, .div = 10 },
                 ^
   drivers/clk/samsung/clk-s3c2410.c:108:14: note: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:109:4: error: field name not in record or union initializer
     { .val = 6, .div = 12 },
       ^
   drivers/clk/samsung/clk-s3c2410.c:109:4: note: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:109:14: error: field name not in record or union initializer
     { .val = 6, .div = 12 },
                 ^
   drivers/clk/samsung/clk-s3c2410.c:109:14: note: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:110:4: error: field name not in record or union initializer
     { .val = 7, .div = 14 },
       ^
   drivers/clk/samsung/clk-s3c2410.c:110:4: note: (near initialization for 'divslow_d')
   drivers/clk/samsung/clk-s3c2410.c:110:14: error: field name not in record or union initializer
     { .val = 7, .div = 14 },
                 ^
   drivers/clk/samsung/clk-s3c2410.c:110:14: note: (near initialization for 'divslow_d')
   In file included from drivers/clk/samsung/clk-s3c2410.c:18:0:
   drivers/clk/samsung/clk-s3c2410.c:115:45: error: initializer element is not constant
     DIV_T(0, "div_slow", "xti", CLKSLOW, 0, 3, divslow_d),
                                                ^
   drivers/clk/samsung/clk.h:200:13: note: in definition of macro '__DIV'
      .table  = t,    \
                ^
>> drivers/clk/samsung/clk-s3c2410.c:115:2: note: in expansion of macro 'DIV_T'
     DIV_T(0, "div_slow", "xti", CLKSLOW, 0, 3, divslow_d),
     ^
   drivers/clk/samsung/clk-s3c2410.c:115:45: note: (near initialization for 's3c2410_common_dividers[0].table')
     DIV_T(0, "div_slow", "xti", CLKSLOW, 0, 3, divslow_d),
                                                ^
   drivers/clk/samsung/clk.h:200:13: note: in definition of macro '__DIV'
      .table  = t,    \
                ^
>> drivers/clk/samsung/clk-s3c2410.c:115:2: note: in expansion of macro 'DIV_T'
     DIV_T(0, "div_slow", "xti", CLKSLOW, 0, 3, divslow_d),
     ^
   drivers/clk/samsung/clk-s3c2410.c:125:46: error: 'CLK_IGNORE_UNUSED' undeclared here (not in a function)
     GATE(PCLK_GPIO, "gpio", "pclk", CLKCON, 13, CLK_IGNORE_UNUSED, 0),
                                                 ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-s3c2410.c:125:2: note: in expansion of macro 'GATE'
     GATE(PCLK_GPIO, "gpio", "pclk", CLKCON, 13, CLK_IGNORE_UNUSED, 0),
     ^
   drivers/clk/samsung/clk-s3c2410.c:125:46: error: initializer element is not constant
     GATE(PCLK_GPIO, "gpio", "pclk", CLKCON, 13, CLK_IGNORE_UNUSED, 0),
                                                 ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-s3c2410.c:125:2: note: in expansion of macro 'GATE'
     GATE(PCLK_GPIO, "gpio", "pclk", CLKCON, 13, CLK_IGNORE_UNUSED, 0),
     ^
   drivers/clk/samsung/clk-s3c2410.c:125:46: note: (near initialization for 's3c2410_common_gates[5].flags')
     GATE(PCLK_GPIO, "gpio", "pclk", CLKCON, 13, CLK_IGNORE_UNUSED, 0),
                                                 ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-s3c2410.c:125:2: note: in expansion of macro 'GATE'
     GATE(PCLK_GPIO, "gpio", "pclk", CLKCON, 13, CLK_IGNORE_UNUSED, 0),
     ^
   drivers/clk/samsung/clk.h:309:13: error: 'CLK_GET_RATE_NOCACHE' undeclared here (not in a function)
      .flags  = CLK_GET_RATE_NOCACHE,   \
                ^
   drivers/clk/samsung/clk.h:317:2: note: in expansion of macro '__PLL'
     __PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE, \
     ^
   drivers/clk/samsung/clk-s3c2410.c:197:11: note: in expansion of macro 'PLL'
     [mpll] = PLL(pll_s3c2410_mpll, MPLL, "mpll", "xti",
              ^
>> drivers/clk/samsung/clk.h:309:13: error: initializer element is not constant
      .flags  = CLK_GET_RATE_NOCACHE,   \
                ^
   drivers/clk/samsung/clk.h:317:2: note: in expansion of macro '__PLL'
     __PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE, \
     ^
   drivers/clk/samsung/clk-s3c2410.c:197:11: note: in expansion of macro 'PLL'
     [mpll] = PLL(pll_s3c2410_mpll, MPLL, "mpll", "xti",
              ^
   drivers/clk/samsung/clk.h:309:13: note: (near initialization for 's3c2410_plls[0].flags')
      .flags  = CLK_GET_RATE_NOCACHE,   \
                ^
   drivers/clk/samsung/clk.h:317:2: note: in expansion of macro '__PLL'
     __PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE, \
     ^
   drivers/clk/samsung/clk-s3c2410.c:197:11: note: in expansion of macro 'PLL'
     [mpll] = PLL(pll_s3c2410_mpll, MPLL, "mpll", "xti",
              ^
>> drivers/clk/samsung/clk.h:309:13: error: initializer element is not constant
      .flags  = CLK_GET_RATE_NOCACHE,   \
                ^
   drivers/clk/samsung/clk.h:317:2: note: in expansion of macro '__PLL'
     __PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE, \
     ^
   drivers/clk/samsung/clk-s3c2410.c:199:11: note: in expansion of macro 'PLL'
     [upll] = PLL(pll_s3c2410_upll, UPLL, "upll", "xti",
              ^
   drivers/clk/samsung/clk.h:309:13: note: (near initialization for 's3c2410_plls[1].flags')
      .flags  = CLK_GET_RATE_NOCACHE,   \
                ^
   drivers/clk/samsung/clk.h:317:2: note: in expansion of macro '__PLL'
     __PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE, \
     ^
   drivers/clk/samsung/clk-s3c2410.c:199:11: note: in expansion of macro 'PLL'
     [upll] = PLL(pll_s3c2410_upll, UPLL, "upll", "xti",
              ^
>> drivers/clk/samsung/clk.h:309:13: error: initializer element is not constant
      .flags  = CLK_GET_RATE_NOCACHE,   \
                ^
   drivers/clk/samsung/clk.h:317:2: note: in expansion of macro '__PLL'
     __PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE, \
     ^
   drivers/clk/samsung/clk-s3c2410.c:263:11: note: in expansion of macro 'PLL'
     [mpll] = PLL(pll_s3c2440_mpll, MPLL, "mpll", "xti",
              ^
   drivers/clk/samsung/clk.h:309:13: note: (near initialization for 's3c244x_common_plls[0].flags')
      .flags  = CLK_GET_RATE_NOCACHE,   \
                ^
   drivers/clk/samsung/clk.h:317:2: note: in expansion of macro '__PLL'
     __PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE, \
     ^
   drivers/clk/samsung/clk-s3c2410.c:263:11: note: in expansion of macro 'PLL'
     [mpll] = PLL(pll_s3c2440_mpll, MPLL, "mpll", "xti",
              ^
>> drivers/clk/samsung/clk.h:309:13: error: initializer element is not constant
      .flags  = CLK_GET_RATE_NOCACHE,   \
                ^
   drivers/clk/samsung/clk.h:317:2: note: in expansion of macro '__PLL'
     __PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE, \
     ^
   drivers/clk/samsung/clk-s3c2410.c:265:11: note: in expansion of macro 'PLL'
     [upll] = PLL(pll_s3c2410_upll, UPLL, "upll", "xti",
              ^
   drivers/clk/samsung/clk.h:309:13: note: (near initialization for 's3c244x_common_plls[1].flags')
      .flags  = CLK_GET_RATE_NOCACHE,   \
                ^
   drivers/clk/samsung/clk.h:317:2: note: in expansion of macro '__PLL'
     __PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE, \
     ^
   drivers/clk/samsung/clk-s3c2410.c:265:11: note: in expansion of macro 'PLL'
     [upll] = PLL(pll_s3c2410_upll, UPLL, "upll", "xti",
              ^
   drivers/clk/samsung/clk.h:142:17: error: invalid operands to binary | (have 'int' and 'struct samsung_pll_clock *')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                    ^
   drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
   drivers/clk/samsung/clk-s3c2410.c:273:2: note: in expansion of macro 'MUX'
     MUX(HCLK, "hclk", hclk_p, CLKDIVN, 1, 2),
     ^
   drivers/clk/samsung/clk.h:142:13: error: initializer element is not constant
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                ^
   drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
   drivers/clk/samsung/clk-s3c2410.c:273:2: note: in expansion of macro 'MUX'
     MUX(HCLK, "hclk", hclk_p, CLKDIVN, 1, 2),
     ^
   drivers/clk/samsung/clk.h:142:13: note: (near initialization for 's3c244x_common_muxes[0].flags')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                ^
   drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
   drivers/clk/samsung/clk-s3c2410.c:273:2: note: in expansion of macro 'MUX'
     MUX(HCLK, "hclk", hclk_p, CLKDIVN, 1, 2),
     ^
   drivers/clk/samsung/clk.h:142:17: error: invalid operands to binary | (have 'int' and 'struct samsung_pll_clock *')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                    ^
   drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
   drivers/clk/samsung/clk-s3c2410.c:274:2: note: in expansion of macro 'MUX'
     MUX(ARMCLK, "armclk", armclk_p, CAMDIVN, 12, 1),
     ^
   drivers/clk/samsung/clk.h:142:13: error: initializer element is not constant
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                ^
   drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
   drivers/clk/samsung/clk-s3c2410.c:274:2: note: in expansion of macro 'MUX'
     MUX(ARMCLK, "armclk", armclk_p, CAMDIVN, 12, 1),
     ^
   drivers/clk/samsung/clk.h:142:13: note: (near initialization for 's3c244x_common_muxes[1].flags')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                ^
   drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
   drivers/clk/samsung/clk-s3c2410.c:274:2: note: in expansion of macro 'MUX'
     MUX(ARMCLK, "armclk", armclk_p, CAMDIVN, 12, 1),
     ^
   drivers/clk/samsung/clk-s3c2410.c:279:40: error: 'CLK_SET_RATE_PARENT' undeclared here (not in a function)
     FFACTOR(0, "ff_cam", "div_cam", 2, 1, CLK_SET_RATE_PARENT),
                                           ^
   drivers/clk/samsung/clk.h:104:13: note: in definition of macro 'FFACTOR'
      .flags  = f,   \
                ^
   drivers/clk/samsung/clk-s3c2410.c:279:40: error: initializer element is not constant
     FFACTOR(0, "ff_cam", "div_cam", 2, 1, CLK_SET_RATE_PARENT),
                                           ^
   drivers/clk/samsung/clk.h:104:13: note: in definition of macro 'FFACTOR'
      .flags  = f,   \
                ^
   drivers/clk/samsung/clk-s3c2410.c:279:40: note: (near initialization for 's3c244x_common_ffactor[1].flags')
     FFACTOR(0, "ff_cam", "div_cam", 2, 1, CLK_SET_RATE_PARENT),
                                           ^
   drivers/clk/samsung/clk.h:104:13: note: in definition of macro 'FFACTOR'
      .flags  = f,   \
                ^
   drivers/clk/samsung/clk-s3c2410.c:282:29: error: array type has incomplete element type 'struct clk_div_table'
    static struct clk_div_table div_hclk_4_d[] = {
                                ^
   drivers/clk/samsung/clk-s3c2410.c:283:4: error: field name not in record or union initializer
     { .val = 0, .div = 4 },
       ^
   drivers/clk/samsung/clk-s3c2410.c:283:4: note: (near initialization for 'div_hclk_4_d')
   drivers/clk/samsung/clk-s3c2410.c:283:14: error: field name not in record or union initializer
     { .val = 0, .div = 4 },
                 ^
   drivers/clk/samsung/clk-s3c2410.c:283:14: note: (near initialization for 'div_hclk_4_d')
--
   In file included from drivers/clk/samsung/clk-s3c2412.c:19:0:
   drivers/clk/samsung/clk.h:29:26: error: field 'clk_data' has incomplete type
     struct clk_onecell_data clk_data;
                             ^
>> drivers/clk/samsung/clk-s3c2412.c:89:29: error: array type has incomplete element type 'struct clk_div_table'
    static struct clk_div_table divxti_d[] = {
                                ^
   drivers/clk/samsung/clk-s3c2412.c:90:4: error: field name not in record or union initializer
     { .val = 0, .div = 1 },
       ^
   drivers/clk/samsung/clk-s3c2412.c:90:4: note: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:90:14: error: field name not in record or union initializer
     { .val = 0, .div = 1 },
                 ^
   drivers/clk/samsung/clk-s3c2412.c:90:14: note: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:91:4: error: field name not in record or union initializer
     { .val = 1, .div = 2 },
       ^
   drivers/clk/samsung/clk-s3c2412.c:91:4: note: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:91:14: error: field name not in record or union initializer
     { .val = 1, .div = 2 },
                 ^
   drivers/clk/samsung/clk-s3c2412.c:91:14: note: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:92:4: error: field name not in record or union initializer
     { .val = 2, .div = 4 },
       ^
   drivers/clk/samsung/clk-s3c2412.c:92:4: note: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:92:14: error: field name not in record or union initializer
     { .val = 2, .div = 4 },
                 ^
   drivers/clk/samsung/clk-s3c2412.c:92:14: note: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:93:4: error: field name not in record or union initializer
     { .val = 3, .div = 6 },
       ^
   drivers/clk/samsung/clk-s3c2412.c:93:4: note: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:93:14: error: field name not in record or union initializer
     { .val = 3, .div = 6 },
                 ^
   drivers/clk/samsung/clk-s3c2412.c:93:14: note: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:94:4: error: field name not in record or union initializer
     { .val = 4, .div = 8 },
       ^
   drivers/clk/samsung/clk-s3c2412.c:94:4: note: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:94:14: error: field name not in record or union initializer
     { .val = 4, .div = 8 },
                 ^
   drivers/clk/samsung/clk-s3c2412.c:94:14: note: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:95:4: error: field name not in record or union initializer
     { .val = 5, .div = 10 },
       ^
   drivers/clk/samsung/clk-s3c2412.c:95:4: note: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:95:14: error: field name not in record or union initializer
     { .val = 5, .div = 10 },
                 ^
   drivers/clk/samsung/clk-s3c2412.c:95:14: note: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:96:4: error: field name not in record or union initializer
     { .val = 6, .div = 12 },
       ^
   drivers/clk/samsung/clk-s3c2412.c:96:4: note: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:96:14: error: field name not in record or union initializer
     { .val = 6, .div = 12 },
                 ^
   drivers/clk/samsung/clk-s3c2412.c:96:14: note: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:97:4: error: field name not in record or union initializer
     { .val = 7, .div = 14 },
       ^
   drivers/clk/samsung/clk-s3c2412.c:97:4: note: (near initialization for 'divxti_d')
   drivers/clk/samsung/clk-s3c2412.c:97:14: error: field name not in record or union initializer
     { .val = 7, .div = 14 },
                 ^
   drivers/clk/samsung/clk-s3c2412.c:97:14: note: (near initialization for 'divxti_d')
   In file included from drivers/clk/samsung/clk-s3c2412.c:19:0:
   drivers/clk/samsung/clk-s3c2412.c:114:38: error: 'CLK_SET_RATE_PARENT' undeclared here (not in a function)
     FFACTOR(0, "ff_hclk", "hclk", 2, 1, CLK_SET_RATE_PARENT),
                                         ^
   drivers/clk/samsung/clk.h:104:13: note: in definition of macro 'FFACTOR'
      .flags  = f,   \
                ^
   drivers/clk/samsung/clk-s3c2412.c:114:38: error: initializer element is not constant
     FFACTOR(0, "ff_hclk", "hclk", 2, 1, CLK_SET_RATE_PARENT),
                                         ^
   drivers/clk/samsung/clk.h:104:13: note: in definition of macro 'FFACTOR'
      .flags  = f,   \
                ^
   drivers/clk/samsung/clk-s3c2412.c:114:38: note: (near initialization for 's3c2412_ffactor[0].flags')
     FFACTOR(0, "ff_hclk", "hclk", 2, 1, CLK_SET_RATE_PARENT),
                                         ^
   drivers/clk/samsung/clk.h:104:13: note: in definition of macro 'FFACTOR'
      .flags  = f,   \
                ^
   drivers/clk/samsung/clk.h:142:19: error: 'CLK_SET_RATE_NO_REPARENT' undeclared here (not in a function)
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                      ^
   drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
   drivers/clk/samsung/clk-s3c2412.c:134:2: note: in expansion of macro 'MUX'
     MUX(0, "erefclk", erefclk_p, CLKSRC, 14, 2),
     ^
   drivers/clk/samsung/clk.h:142:17: error: invalid operands to binary | (have 'int' and 'struct samsung_fixed_factor_clock *')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                    ^
   drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
..

vim +102 drivers/clk/samsung/clk-s3c2410.c

3f7c01ad Heiko Stuebner 2014-05-09   93  static void s3c2410_clk_sleep_init(void) {}
3f7c01ad Heiko Stuebner 2014-05-09   94  #endif
3f7c01ad Heiko Stuebner 2014-05-09   95  
3f7c01ad Heiko Stuebner 2014-05-09   96  PNAME(fclk_p) = { "mpll", "div_slow" };
3f7c01ad Heiko Stuebner 2014-05-09   97  
3f7c01ad Heiko Stuebner 2014-05-09   98  struct samsung_mux_clock s3c2410_common_muxes[] __initdata = {
3f7c01ad Heiko Stuebner 2014-05-09  @99  	MUX(FCLK, "fclk", fclk_p, CLKSLOW, 4, 1),
3f7c01ad Heiko Stuebner 2014-05-09  100  };
3f7c01ad Heiko Stuebner 2014-05-09  101  
3f7c01ad Heiko Stuebner 2014-05-09 @102  static struct clk_div_table divslow_d[] = {
3f7c01ad Heiko Stuebner 2014-05-09  103  	{ .val = 0, .div = 1 },
3f7c01ad Heiko Stuebner 2014-05-09  104  	{ .val = 1, .div = 2 },
3f7c01ad Heiko Stuebner 2014-05-09  105  	{ .val = 2, .div = 4 },
3f7c01ad Heiko Stuebner 2014-05-09  106  	{ .val = 3, .div = 6 },
3f7c01ad Heiko Stuebner 2014-05-09  107  	{ .val = 4, .div = 8 },
3f7c01ad Heiko Stuebner 2014-05-09  108  	{ .val = 5, .div = 10 },
3f7c01ad Heiko Stuebner 2014-05-09  109  	{ .val = 6, .div = 12 },
3f7c01ad Heiko Stuebner 2014-05-09 @110  	{ .val = 7, .div = 14 },
3f7c01ad Heiko Stuebner 2014-05-09  111  	{ /* sentinel */ },
3f7c01ad Heiko Stuebner 2014-05-09  112  };
3f7c01ad Heiko Stuebner 2014-05-09  113  
3f7c01ad Heiko Stuebner 2014-05-09  114  struct samsung_div_clock s3c2410_common_dividers[] __initdata = {
3f7c01ad Heiko Stuebner 2014-05-09 @115  	DIV_T(0, "div_slow", "xti", CLKSLOW, 0, 3, divslow_d),
3f7c01ad Heiko Stuebner 2014-05-09  116  	DIV(PCLK, "pclk", "hclk", CLKDIVN, 0, 1),
3f7c01ad Heiko Stuebner 2014-05-09  117  };
3f7c01ad Heiko Stuebner 2014-05-09  118  

:::::: The code at line 102 was first introduced by commit
:::::: 3f7c01ade226e7006d76e42f8c9b99ada7085312 clk: samsung: add clock controller driver for s3c2410, s3c2440 and s3c2442

:::::: TO: Heiko Stuebner <heiko@sntech.de>
:::::: CC: Kukjin Kim <kgene.kim@samsung.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 40448 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160217/47c79e03/attachment-0001.obj>
