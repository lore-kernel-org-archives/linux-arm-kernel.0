From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 17 Feb 2016 11:22:07 +0800
Subject: [clk:clk-samsung-kconfig 2/2] drivers/clk/samsung/clk.h:142:17:
 error: invalid operands to binary | (have 'struct samsung_pll_clock *' and
 'struct samsung_pll_clock *')
Message-ID: <201602171104.YkeaxmIS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-samsung-kconfig
head:   e83cb468452c25597e868d1ed778fa73fdaeca4c
commit: e83cb468452c25597e868d1ed778fa73fdaeca4c [2/2] clk: samsung: Don't build ARMv8 clock drivers on ARMv7
config: mips-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout e83cb468452c25597e868d1ed778fa73fdaeca4c
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   drivers/clk/samsung/clk-exynos5433.c:3178:7: note: (near initialization for 'bus2_gate_clks[2].flags')
       1, CLK_IGNORE_UNUSED, 0),
          ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3176:2: note: in expansion of macro 'GATE'
     GATE(CLK_ACLK_BUS2BEND_400, "aclk_bus2bend_400",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3181:7: error: initializer element is not constant
       0, CLK_IGNORE_UNUSED, 0),
          ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3179:2: note: in expansion of macro 'GATE'
     GATE(CLK_ACLK_BUS2RTND_400, "aclk_bus2rtnd_400",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3181:7: note: (near initialization for 'bus2_gate_clks[3].flags')
       0, CLK_IGNORE_UNUSED, 0),
          ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3179:2: note: in expansion of macro 'GATE'
     GATE(CLK_ACLK_BUS2RTND_400, "aclk_bus2rtnd_400",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3187:24: error: initializer element is not constant
       ENABLE_PCLK_BUS, 1, CLK_IGNORE_UNUSED, 0),
                           ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3186:2: note: in expansion of macro 'GATE'
     GATE(CLK_PCLK_PMU_BUS, "pclk_pmu_bus2", "div_pclk_bus2_133",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3187:24: note: (near initialization for 'bus2_gate_clks[5].flags')
       ENABLE_PCLK_BUS, 1, CLK_IGNORE_UNUSED, 0),
                           ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3186:2: note: in expansion of macro 'GATE'
     GATE(CLK_PCLK_PMU_BUS, "pclk_pmu_bus2", "div_pclk_bus2_133",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3189:24: error: initializer element is not constant
       ENABLE_PCLK_BUS, 0, CLK_IGNORE_UNUSED, 0),
                           ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3188:2: note: in expansion of macro 'GATE'
     GATE(CLK_PCLK_SYSREG_BUS, "pclk_sysreg_bus2", "div_pclk_bus2_133",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3189:24: note: (near initialization for 'bus2_gate_clks[6].flags')
       ENABLE_PCLK_BUS, 0, CLK_IGNORE_UNUSED, 0),
                           ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3188:2: note: in expansion of macro 'GATE'
     GATE(CLK_PCLK_SYSREG_BUS, "pclk_sysreg_bus2", "div_pclk_bus2_133",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3225:3: error: expected ')' before string constant
      "samsung,exynos5433-cmu-bus"#id,   \
      ^
   drivers/clk/samsung/clk-exynos5433.c:3228:1: note: in expansion of macro 'exynos5433_cmu_bus_init'
    exynos5433_cmu_bus_init(0);
    ^
   drivers/clk/samsung/clk-exynos5433.c:3225:3: error: expected ')' before string constant
      "samsung,exynos5433-cmu-bus"#id,   \
      ^
   drivers/clk/samsung/clk-exynos5433.c:3229:1: note: in expansion of macro 'exynos5433_cmu_bus_init'
    exynos5433_cmu_bus_init(1);
    ^
   drivers/clk/samsung/clk-exynos5433.c:3225:3: error: expected ')' before string constant
      "samsung,exynos5433-cmu-bus"#id,   \
      ^
   drivers/clk/samsung/clk-exynos5433.c:3230:1: note: in expansion of macro 'exynos5433_cmu_bus_init'
    exynos5433_cmu_bus_init(2);
    ^
   In file included from drivers/clk/samsung/clk-exynos5433.c:17:0:
   drivers/clk/samsung/clk.h:309:13: error: initializer element is not constant
      .flags  = CLK_GET_RATE_NOCACHE,   \
                ^
   drivers/clk/samsung/clk.h:317:2: note: in expansion of macro '__PLL'
     __PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE, \
     ^
   drivers/clk/samsung/clk-exynos5433.c:3282:2: note: in expansion of macro 'PLL'
     PLL(pll_35xx, CLK_FOUT_G3D_PLL, "fout_g3d_pll", "oscclk",
     ^
   drivers/clk/samsung/clk.h:309:13: note: (near initialization for 'g3d_pll_clks[0].flags')
      .flags  = CLK_GET_RATE_NOCACHE,   \
                ^
   drivers/clk/samsung/clk.h:317:2: note: in expansion of macro '__PLL'
     __PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE, \
     ^
   drivers/clk/samsung/clk-exynos5433.c:3282:2: note: in expansion of macro 'PLL'
     PLL(pll_35xx, CLK_FOUT_G3D_PLL, "fout_g3d_pll", "oscclk",
     ^
>> drivers/clk/samsung/clk.h:142:17: error: invalid operands to binary | (have 'struct samsung_pll_clock *' and 'struct samsung_pll_clock *')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                    ^
   drivers/clk/samsung/clk.h:157:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, f, mf, NULL)
     ^
   drivers/clk/samsung/clk-exynos5433.c:3288:2: note: in expansion of macro 'MUX_F'
     MUX_F(CLK_MOUT_ACLK_G3D_400, "mout_aclk_g3d_400", mout_aclk_g3d_400_p,
     ^
   drivers/clk/samsung/clk.h:142:13: error: initializer element is not constant
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                ^
   drivers/clk/samsung/clk.h:157:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, f, mf, NULL)
     ^
   drivers/clk/samsung/clk-exynos5433.c:3288:2: note: in expansion of macro 'MUX_F'
     MUX_F(CLK_MOUT_ACLK_G3D_400, "mout_aclk_g3d_400", mout_aclk_g3d_400_p,
     ^
   drivers/clk/samsung/clk.h:142:13: note: (near initialization for 'g3d_mux_clks[0].flags')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                ^
   drivers/clk/samsung/clk.h:157:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, f, mf, NULL)
     ^
   drivers/clk/samsung/clk-exynos5433.c:3288:2: note: in expansion of macro 'MUX_F'
     MUX_F(CLK_MOUT_ACLK_G3D_400, "mout_aclk_g3d_400", mout_aclk_g3d_400_p,
     ^
>> drivers/clk/samsung/clk.h:142:17: error: invalid operands to binary | (have 'struct samsung_pll_clock *' and 'struct samsung_pll_clock *')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                    ^
   drivers/clk/samsung/clk.h:157:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, f, mf, NULL)
     ^
   drivers/clk/samsung/clk-exynos5433.c:3290:2: note: in expansion of macro 'MUX_F'
     MUX_F(CLK_MOUT_G3D_PLL, "mout_g3d_pll", mout_g3d_pll_p,
     ^
   drivers/clk/samsung/clk.h:142:13: error: initializer element is not constant
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                ^
   drivers/clk/samsung/clk.h:157:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, f, mf, NULL)
     ^
   drivers/clk/samsung/clk-exynos5433.c:3290:2: note: in expansion of macro 'MUX_F'
     MUX_F(CLK_MOUT_G3D_PLL, "mout_g3d_pll", mout_g3d_pll_p,
     ^
   drivers/clk/samsung/clk.h:142:13: note: (near initialization for 'g3d_mux_clks[1].flags')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                ^
   drivers/clk/samsung/clk.h:157:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, f, mf, NULL)
     ^
   drivers/clk/samsung/clk-exynos5433.c:3290:2: note: in expansion of macro 'MUX_F'
     MUX_F(CLK_MOUT_G3D_PLL, "mout_g3d_pll", mout_g3d_pll_p,
     ^
   drivers/clk/samsung/clk-exynos5433.c:3301:10: error: initializer element is not constant
       0, 3, CLK_SET_RATE_PARENT, 0),
             ^
   drivers/clk/samsung/clk.h:194:13: note: in definition of macro '__DIV'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3300:2: note: in expansion of macro 'DIV_F'
     DIV_F(CLK_DIV_ACLK_G3D, "div_aclk_g3d", "mout_aclk_g3d_400", DIV_G3D,
     ^
   drivers/clk/samsung/clk-exynos5433.c:3301:10: note: (near initialization for 'g3d_div_clks[2].flags')
       0, 3, CLK_SET_RATE_PARENT, 0),
             ^
   drivers/clk/samsung/clk.h:194:13: note: in definition of macro '__DIV'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3300:2: note: in expansion of macro 'DIV_F'
     DIV_F(CLK_DIV_ACLK_G3D, "div_aclk_g3d", "mout_aclk_g3d_400", DIV_G3D,
     ^
   drivers/clk/samsung/clk-exynos5433.c:3311:24: error: initializer element is not constant
       ENABLE_ACLK_G3D, 5, CLK_IGNORE_UNUSED, 0),
                           ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3310:2: note: in expansion of macro 'GATE'
     GATE(CLK_ACLK_ASYNCAPBS_G3D, "aclk_asyncapbs_g3d", "div_pclk_g3d",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3311:24: note: (near initialization for 'g3d_gate_clks[2].flags')
       ENABLE_ACLK_G3D, 5, CLK_IGNORE_UNUSED, 0),
                           ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3310:2: note: in expansion of macro 'GATE'
     GATE(CLK_ACLK_ASYNCAPBS_G3D, "aclk_asyncapbs_g3d", "div_pclk_g3d",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3313:24: error: initializer element is not constant
       ENABLE_ACLK_G3D, 4, CLK_IGNORE_UNUSED, 0),
                           ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3312:2: note: in expansion of macro 'GATE'
     GATE(CLK_ACLK_ASYNCAPBM_G3D, "aclk_asyncapbm_g3d", "div_aclk_g3d",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3313:24: note: (near initialization for 'g3d_gate_clks[3].flags')
       ENABLE_ACLK_G3D, 4, CLK_IGNORE_UNUSED, 0),
                           ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3312:2: note: in expansion of macro 'GATE'
     GATE(CLK_ACLK_ASYNCAPBM_G3D, "aclk_asyncapbm_g3d", "div_aclk_g3d",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3315:24: error: initializer element is not constant
       ENABLE_ACLK_G3D, 3, CLK_IGNORE_UNUSED, 0),
                           ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3314:2: note: in expansion of macro 'GATE'
     GATE(CLK_ACLK_AHB2APB_G3DP, "aclk_ahb2apb_g3dp", "div_pclk_g3d",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3315:24: note: (near initialization for 'g3d_gate_clks[4].flags')
       ENABLE_ACLK_G3D, 3, CLK_IGNORE_UNUSED, 0),
                           ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3314:2: note: in expansion of macro 'GATE'
     GATE(CLK_ACLK_AHB2APB_G3DP, "aclk_ahb2apb_g3dp", "div_pclk_g3d",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3317:24: error: initializer element is not constant
       ENABLE_ACLK_G3D, 2, CLK_IGNORE_UNUSED, 0),
--
   drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
   drivers/clk/samsung/clk-exynos5433.c:3406:2: note: in expansion of macro 'MUX'
     MUX(CLK_MOUT_ACLK_GSCL_333_USER, "mout_aclk_gscl_333_user",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3420:7: error: initializer element is not constant
       8, CLK_IGNORE_UNUSED, 0),
          ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3418:2: note: in expansion of macro 'GATE'
     GATE(CLK_ACLK_AHB2APB_GSCLP, "aclk_ahb2apb_gsclp",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3420:7: note: (near initialization for 'gscl_gate_clks[3].flags')
       8, CLK_IGNORE_UNUSED, 0),
          ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3418:2: note: in expansion of macro 'GATE'
     GATE(CLK_ACLK_AHB2APB_GSCLP, "aclk_ahb2apb_gsclp",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3424:25: error: initializer element is not constant
       ENABLE_ACLK_GSCL, 6, CLK_IGNORE_UNUSED, 0),
                            ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3423:2: note: in expansion of macro 'GATE'
     GATE(CLK_ACLK_GSCLNP_111, "aclk_gsclnp_111", "mout_aclk_gscl_111_user",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3424:25: note: (near initialization for 'gscl_gate_clks[5].flags')
       ENABLE_ACLK_GSCL, 6, CLK_IGNORE_UNUSED, 0),
                            ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3423:2: note: in expansion of macro 'GATE'
     GATE(CLK_ACLK_GSCLNP_111, "aclk_gsclnp_111", "mout_aclk_gscl_111_user",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3458:25: error: initializer element is not constant
       ENABLE_PCLK_GSCL, 4, CLK_IGNORE_UNUSED, 0),
                            ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3457:2: note: in expansion of macro 'GATE'
     GATE(CLK_PCLK_PMU_GSCL, "pclk_pmu_gscl", "mout_aclk_gscl_111_user",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3458:25: note: (near initialization for 'gscl_gate_clks[18].flags')
       ENABLE_PCLK_GSCL, 4, CLK_IGNORE_UNUSED, 0),
                            ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3457:2: note: in expansion of macro 'GATE'
     GATE(CLK_PCLK_PMU_GSCL, "pclk_pmu_gscl", "mout_aclk_gscl_111_user",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3461:7: error: initializer element is not constant
       3, CLK_IGNORE_UNUSED, 0),
          ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3459:2: note: in expansion of macro 'GATE'
     GATE(CLK_PCLK_SYSREG_GSCL, "pclk_sysreg_gscl",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3461:7: note: (near initialization for 'gscl_gate_clks[19].flags')
       3, CLK_IGNORE_UNUSED, 0),
          ^
   drivers/clk/samsung/clk.h:245:13: note: in definition of macro '__GATE'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3459:2: note: in expansion of macro 'GATE'
     GATE(CLK_PCLK_SYSREG_GSCL, "pclk_sysreg_gscl",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3496:37: error: expected ')' before string constant
    CLK_OF_DECLARE(exynos5433_cmu_gscl, "samsung,exynos5433-cmu-gscl",
                                        ^
   In file included from drivers/clk/samsung/clk-exynos5433.c:17:0:
   drivers/clk/samsung/clk.h:309:13: error: initializer element is not constant
      .flags  = CLK_GET_RATE_NOCACHE,   \
                ^
   drivers/clk/samsung/clk.h:317:2: note: in expansion of macro '__PLL'
     __PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE, \
     ^
   drivers/clk/samsung/clk-exynos5433.c:3577:2: note: in expansion of macro 'PLL'
     PLL(pll_35xx, CLK_FOUT_APOLLO_PLL, "fout_apollo_pll", "oscclk",
     ^
   drivers/clk/samsung/clk.h:309:13: note: (near initialization for 'apollo_pll_clks[0].flags')
      .flags  = CLK_GET_RATE_NOCACHE,   \
                ^
   drivers/clk/samsung/clk.h:317:2: note: in expansion of macro '__PLL'
     __PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE, \
     ^
   drivers/clk/samsung/clk-exynos5433.c:3577:2: note: in expansion of macro 'PLL'
     PLL(pll_35xx, CLK_FOUT_APOLLO_PLL, "fout_apollo_pll", "oscclk",
     ^
>> drivers/clk/samsung/clk.h:142:17: error: invalid operands to binary | (have 'struct samsung_pll_clock *' and 'struct samsung_pll_clock *')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                    ^
   drivers/clk/samsung/clk.h:157:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, f, mf, NULL)
     ^
   drivers/clk/samsung/clk-exynos5433.c:3583:2: note: in expansion of macro 'MUX_F'
     MUX_F(CLK_MOUT_APOLLO_PLL, "mout_apollo_pll", mout_apollo_pll_p,
     ^
   drivers/clk/samsung/clk.h:142:13: error: initializer element is not constant
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                ^
   drivers/clk/samsung/clk.h:157:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, f, mf, NULL)
     ^
   drivers/clk/samsung/clk-exynos5433.c:3583:2: note: in expansion of macro 'MUX_F'
     MUX_F(CLK_MOUT_APOLLO_PLL, "mout_apollo_pll", mout_apollo_pll_p,
     ^
   drivers/clk/samsung/clk.h:142:13: note: (near initialization for 'apollo_mux_clks[0].flags')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                ^
   drivers/clk/samsung/clk.h:157:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, f, mf, NULL)
     ^
   drivers/clk/samsung/clk-exynos5433.c:3583:2: note: in expansion of macro 'MUX_F'
     MUX_F(CLK_MOUT_APOLLO_PLL, "mout_apollo_pll", mout_apollo_pll_p,
     ^
   drivers/clk/samsung/clk.h:142:17: error: invalid operands to binary | (have 'int' and 'struct samsung_pll_clock *')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                    ^
   drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
   drivers/clk/samsung/clk-exynos5433.c:3587:2: note: in expansion of macro 'MUX'
     MUX(CLK_MOUT_BUS_PLL_APOLLO_USER, "mout_bus_pll_apollo_user",
     ^
   drivers/clk/samsung/clk.h:142:13: error: initializer element is not constant
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                ^
   drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
   drivers/clk/samsung/clk-exynos5433.c:3587:2: note: in expansion of macro 'MUX'
     MUX(CLK_MOUT_BUS_PLL_APOLLO_USER, "mout_bus_pll_apollo_user",
     ^
   drivers/clk/samsung/clk.h:142:13: note: (near initialization for 'apollo_mux_clks[1].flags')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                ^
   drivers/clk/samsung/clk.h:151:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
     ^
   drivers/clk/samsung/clk-exynos5433.c:3587:2: note: in expansion of macro 'MUX'
     MUX(CLK_MOUT_BUS_PLL_APOLLO_USER, "mout_bus_pll_apollo_user",
     ^
>> drivers/clk/samsung/clk.h:142:17: error: invalid operands to binary | (have 'struct samsung_pll_clock *' and 'struct samsung_pll_clock *')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                    ^
   drivers/clk/samsung/clk.h:157:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, f, mf, NULL)
     ^
   drivers/clk/samsung/clk-exynos5433.c:3591:2: note: in expansion of macro 'MUX_F'
     MUX_F(CLK_MOUT_APOLLO, "mout_apollo", mout_apollo_p, MUX_SEL_APOLLO2,
     ^
   drivers/clk/samsung/clk.h:142:13: error: initializer element is not constant
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                ^
   drivers/clk/samsung/clk.h:157:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, f, mf, NULL)
     ^
   drivers/clk/samsung/clk-exynos5433.c:3591:2: note: in expansion of macro 'MUX_F'
     MUX_F(CLK_MOUT_APOLLO, "mout_apollo", mout_apollo_p, MUX_SEL_APOLLO2,
     ^
   drivers/clk/samsung/clk.h:142:13: note: (near initialization for 'apollo_mux_clks[2].flags')
      .flags  = (f) | CLK_SET_RATE_NO_REPARENT, \
                ^
   drivers/clk/samsung/clk.h:157:2: note: in expansion of macro '__MUX'
     __MUX(_id, NULL, cname, pnames, o, s, w, f, mf, NULL)
     ^
   drivers/clk/samsung/clk-exynos5433.c:3591:2: note: in expansion of macro 'MUX_F'
     MUX_F(CLK_MOUT_APOLLO, "mout_apollo", mout_apollo_p, MUX_SEL_APOLLO2,
     ^
   drivers/clk/samsung/clk-exynos5433.c:3598:24: error: initializer element is not constant
       DIV_APOLLO0, 24, 3, CLK_GET_RATE_NOCACHE,
                           ^
   drivers/clk/samsung/clk.h:194:13: note: in definition of macro '__DIV'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3597:2: note: in expansion of macro 'DIV_F'
     DIV_F(CLK_DIV_CNTCLK_APOLLO, "div_cntclk_apollo", "div_apollo2",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3598:24: note: (near initialization for 'apollo_div_clks[0].flags')
       DIV_APOLLO0, 24, 3, CLK_GET_RATE_NOCACHE,
                           ^
   drivers/clk/samsung/clk.h:194:13: note: in definition of macro '__DIV'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3597:2: note: in expansion of macro 'DIV_F'
     DIV_F(CLK_DIV_CNTCLK_APOLLO, "div_cntclk_apollo", "div_apollo2",
     ^
>> drivers/clk/samsung/clk-exynos5433.c:3599:4: error: 'CLK_DIVIDER_READ_ONLY' undeclared here (not in a function)
       CLK_DIVIDER_READ_ONLY),
       ^
   drivers/clk/samsung/clk.h:198:16: note: in definition of macro '__DIV'
      .div_flags = df,    \
                   ^
   drivers/clk/samsung/clk-exynos5433.c:3597:2: note: in expansion of macro 'DIV_F'
     DIV_F(CLK_DIV_CNTCLK_APOLLO, "div_cntclk_apollo", "div_apollo2",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3599:4: error: initializer element is not constant
       CLK_DIVIDER_READ_ONLY),
       ^
   drivers/clk/samsung/clk.h:198:16: note: in definition of macro '__DIV'
      .div_flags = df,    \
                   ^
   drivers/clk/samsung/clk-exynos5433.c:3597:2: note: in expansion of macro 'DIV_F'
     DIV_F(CLK_DIV_CNTCLK_APOLLO, "div_cntclk_apollo", "div_apollo2",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3599:4: note: (near initialization for 'apollo_div_clks[0].div_flags')
       CLK_DIVIDER_READ_ONLY),
       ^
   drivers/clk/samsung/clk.h:198:16: note: in definition of macro '__DIV'
      .div_flags = df,    \
                   ^
   drivers/clk/samsung/clk-exynos5433.c:3597:2: note: in expansion of macro 'DIV_F'
     DIV_F(CLK_DIV_CNTCLK_APOLLO, "div_cntclk_apollo", "div_apollo2",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3601:24: error: initializer element is not constant
       DIV_APOLLO0, 20, 3, CLK_GET_RATE_NOCACHE,
                           ^
   drivers/clk/samsung/clk.h:194:13: note: in definition of macro '__DIV'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3600:2: note: in expansion of macro 'DIV_F'
     DIV_F(CLK_DIV_PCLK_DBG_APOLLO, "div_pclk_dbg_apollo", "div_apollo2",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3601:24: note: (near initialization for 'apollo_div_clks[1].flags')
       DIV_APOLLO0, 20, 3, CLK_GET_RATE_NOCACHE,
                           ^
   drivers/clk/samsung/clk.h:194:13: note: in definition of macro '__DIV'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3600:2: note: in expansion of macro 'DIV_F'
     DIV_F(CLK_DIV_PCLK_DBG_APOLLO, "div_pclk_dbg_apollo", "div_apollo2",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3602:4: error: initializer element is not constant
       CLK_DIVIDER_READ_ONLY),
       ^
   drivers/clk/samsung/clk.h:198:16: note: in definition of macro '__DIV'
      .div_flags = df,    \
                   ^
   drivers/clk/samsung/clk-exynos5433.c:3600:2: note: in expansion of macro 'DIV_F'
     DIV_F(CLK_DIV_PCLK_DBG_APOLLO, "div_pclk_dbg_apollo", "div_apollo2",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3602:4: note: (near initialization for 'apollo_div_clks[1].div_flags')
       CLK_DIVIDER_READ_ONLY),
       ^
   drivers/clk/samsung/clk.h:198:16: note: in definition of macro '__DIV'
      .div_flags = df,    \
                   ^
   drivers/clk/samsung/clk-exynos5433.c:3600:2: note: in expansion of macro 'DIV_F'
     DIV_F(CLK_DIV_PCLK_DBG_APOLLO, "div_pclk_dbg_apollo", "div_apollo2",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3604:24: error: initializer element is not constant
       DIV_APOLLO0, 16, 3, CLK_GET_RATE_NOCACHE,
                           ^
   drivers/clk/samsung/clk.h:194:13: note: in definition of macro '__DIV'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3603:2: note: in expansion of macro 'DIV_F'
     DIV_F(CLK_DIV_ATCLK_APOLLO, "div_atclk_apollo", "div_apollo2",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3604:24: note: (near initialization for 'apollo_div_clks[2].flags')
       DIV_APOLLO0, 16, 3, CLK_GET_RATE_NOCACHE,
                           ^
   drivers/clk/samsung/clk.h:194:13: note: in definition of macro '__DIV'
      .flags  = f,    \
                ^
   drivers/clk/samsung/clk-exynos5433.c:3603:2: note: in expansion of macro 'DIV_F'
     DIV_F(CLK_DIV_ATCLK_APOLLO, "div_atclk_apollo", "div_apollo2",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3605:4: error: initializer element is not constant
       CLK_DIVIDER_READ_ONLY),
       ^
   drivers/clk/samsung/clk.h:198:16: note: in definition of macro '__DIV'
      .div_flags = df,    \
                   ^
   drivers/clk/samsung/clk-exynos5433.c:3603:2: note: in expansion of macro 'DIV_F'
     DIV_F(CLK_DIV_ATCLK_APOLLO, "div_atclk_apollo", "div_apollo2",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3605:4: note: (near initialization for 'apollo_div_clks[2].div_flags')
       CLK_DIVIDER_READ_ONLY),
       ^
   drivers/clk/samsung/clk.h:198:16: note: in definition of macro '__DIV'
      .div_flags = df,    \
                   ^
   drivers/clk/samsung/clk-exynos5433.c:3603:2: note: in expansion of macro 'DIV_F'
     DIV_F(CLK_DIV_ATCLK_APOLLO, "div_atclk_apollo", "div_apollo2",
     ^
   drivers/clk/samsung/clk-exynos5433.c:3607:24: error: initializer element is not constant
       DIV_APOLLO0, 12, 3, CLK_GET_RATE_NOCACHE,
..

vim +142 drivers/clk/samsung/clk.h

721c42a3 Thomas Abraham       2013-03-09  136  	{							\
721c42a3 Thomas Abraham       2013-03-09  137  		.id		= _id,				\
721c42a3 Thomas Abraham       2013-03-09  138  		.dev_name	= dname,			\
721c42a3 Thomas Abraham       2013-03-09  139  		.name		= cname,			\
721c42a3 Thomas Abraham       2013-03-09  140  		.parent_names	= pnames,			\
721c42a3 Thomas Abraham       2013-03-09  141  		.num_parents	= ARRAY_SIZE(pnames),		\
819c1de3 James Hogan          2013-07-29 @142  		.flags		= (f) | CLK_SET_RATE_NO_REPARENT, \
721c42a3 Thomas Abraham       2013-03-09  143  		.offset		= o,				\
721c42a3 Thomas Abraham       2013-03-09  144  		.shift		= s,				\
721c42a3 Thomas Abraham       2013-03-09  145  		.width		= w,				\
721c42a3 Thomas Abraham       2013-03-09  146  		.mux_flags	= mf,				\
721c42a3 Thomas Abraham       2013-03-09  147  		.alias		= a,				\
721c42a3 Thomas Abraham       2013-03-09  148  	}
721c42a3 Thomas Abraham       2013-03-09  149  
721c42a3 Thomas Abraham       2013-03-09  150  #define MUX(_id, cname, pnames, o, s, w)			\
721c42a3 Thomas Abraham       2013-03-09  151  	__MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
721c42a3 Thomas Abraham       2013-03-09  152  
721c42a3 Thomas Abraham       2013-03-09  153  #define MUX_A(_id, cname, pnames, o, s, w, a)			\
721c42a3 Thomas Abraham       2013-03-09  154  	__MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, a)
721c42a3 Thomas Abraham       2013-03-09  155  
721c42a3 Thomas Abraham       2013-03-09  156  #define MUX_F(_id, cname, pnames, o, s, w, f, mf)		\
721c42a3 Thomas Abraham       2013-03-09  157  	__MUX(_id, NULL, cname, pnames, o, s, w, f, mf, NULL)
721c42a3 Thomas Abraham       2013-03-09  158  
41ccf7f2 Tushar Behera        2013-06-20  159  #define MUX_FA(_id, cname, pnames, o, s, w, f, mf, a)		\
41ccf7f2 Tushar Behera        2013-06-20  160  	__MUX(_id, NULL, cname, pnames, o, s, w, f, mf, a)
41ccf7f2 Tushar Behera        2013-06-20  161  
721c42a3 Thomas Abraham       2013-03-09  162  /**
721c42a3 Thomas Abraham       2013-03-09  163   * @id: platform specific id of the clock.
721c42a3 Thomas Abraham       2013-03-09  164   * struct samsung_div_clock: information about div clock
721c42a3 Thomas Abraham       2013-03-09  165   * @dev_name: name of the device to which this clock belongs.
721c42a3 Thomas Abraham       2013-03-09  166   * @name: name of this div clock.
721c42a3 Thomas Abraham       2013-03-09  167   * @parent_name: name of the parent clock.
721c42a3 Thomas Abraham       2013-03-09  168   * @flags: optional flags for basic clock.
721c42a3 Thomas Abraham       2013-03-09  169   * @offset: offset of the register for configuring the div.
721c42a3 Thomas Abraham       2013-03-09  170   * @shift: starting bit location of the div control bit-field in @reg.
721c42a3 Thomas Abraham       2013-03-09  171   * @div_flags: flags for div-type clock.
721c42a3 Thomas Abraham       2013-03-09  172   * @alias: optional clock alias name to be assigned to this clock.
721c42a3 Thomas Abraham       2013-03-09  173   */
721c42a3 Thomas Abraham       2013-03-09  174  struct samsung_div_clock {
721c42a3 Thomas Abraham       2013-03-09  175  	unsigned int		id;
721c42a3 Thomas Abraham       2013-03-09  176  	const char		*dev_name;
721c42a3 Thomas Abraham       2013-03-09  177  	const char		*name;
721c42a3 Thomas Abraham       2013-03-09  178  	const char		*parent_name;
721c42a3 Thomas Abraham       2013-03-09  179  	unsigned long		flags;
721c42a3 Thomas Abraham       2013-03-09  180  	unsigned long		offset;
721c42a3 Thomas Abraham       2013-03-09  181  	u8			shift;
721c42a3 Thomas Abraham       2013-03-09  182  	u8			width;
721c42a3 Thomas Abraham       2013-03-09  183  	u8			div_flags;
721c42a3 Thomas Abraham       2013-03-09  184  	const char		*alias;
798ed613 Heiko Stuebner       2013-03-18  185  	struct clk_div_table	*table;
721c42a3 Thomas Abraham       2013-03-09  186  };
721c42a3 Thomas Abraham       2013-03-09  187  
798ed613 Heiko Stuebner       2013-03-18  188  #define __DIV(_id, dname, cname, pname, o, s, w, f, df, a, t)	\
721c42a3 Thomas Abraham       2013-03-09  189  	{							\
721c42a3 Thomas Abraham       2013-03-09  190  		.id		= _id,				\
721c42a3 Thomas Abraham       2013-03-09  191  		.dev_name	= dname,			\
721c42a3 Thomas Abraham       2013-03-09  192  		.name		= cname,			\
721c42a3 Thomas Abraham       2013-03-09  193  		.parent_name	= pname,			\
721c42a3 Thomas Abraham       2013-03-09  194  		.flags		= f,				\
721c42a3 Thomas Abraham       2013-03-09  195  		.offset		= o,				\
721c42a3 Thomas Abraham       2013-03-09  196  		.shift		= s,				\
721c42a3 Thomas Abraham       2013-03-09  197  		.width		= w,				\
721c42a3 Thomas Abraham       2013-03-09  198  		.div_flags	= df,				\
721c42a3 Thomas Abraham       2013-03-09  199  		.alias		= a,				\
798ed613 Heiko Stuebner       2013-03-18  200  		.table		= t,				\
721c42a3 Thomas Abraham       2013-03-09  201  	}
721c42a3 Thomas Abraham       2013-03-09  202  
721c42a3 Thomas Abraham       2013-03-09  203  #define DIV(_id, cname, pname, o, s, w)				\
798ed613 Heiko Stuebner       2013-03-18  204  	__DIV(_id, NULL, cname, pname, o, s, w, 0, 0, NULL, NULL)
721c42a3 Thomas Abraham       2013-03-09  205  
721c42a3 Thomas Abraham       2013-03-09  206  #define DIV_A(_id, cname, pname, o, s, w, a)			\
798ed613 Heiko Stuebner       2013-03-18  207  	__DIV(_id, NULL, cname, pname, o, s, w, 0, 0, a, NULL)
721c42a3 Thomas Abraham       2013-03-09  208  
721c42a3 Thomas Abraham       2013-03-09  209  #define DIV_F(_id, cname, pname, o, s, w, f, df)		\
798ed613 Heiko Stuebner       2013-03-18  210  	__DIV(_id, NULL, cname, pname, o, s, w, f, df, NULL, NULL)
798ed613 Heiko Stuebner       2013-03-18  211  
798ed613 Heiko Stuebner       2013-03-18  212  #define DIV_T(_id, cname, pname, o, s, w, t)			\
798ed613 Heiko Stuebner       2013-03-18  213  	__DIV(_id, NULL, cname, pname, o, s, w, 0, 0, NULL, t)
721c42a3 Thomas Abraham       2013-03-09  214  
721c42a3 Thomas Abraham       2013-03-09  215  /**
721c42a3 Thomas Abraham       2013-03-09  216   * struct samsung_gate_clock: information about gate clock
721c42a3 Thomas Abraham       2013-03-09  217   * @id: platform specific id of the clock.
721c42a3 Thomas Abraham       2013-03-09  218   * @dev_name: name of the device to which this clock belongs.
721c42a3 Thomas Abraham       2013-03-09  219   * @name: name of this gate clock.
721c42a3 Thomas Abraham       2013-03-09  220   * @parent_name: name of the parent clock.
721c42a3 Thomas Abraham       2013-03-09  221   * @flags: optional flags for basic clock.
721c42a3 Thomas Abraham       2013-03-09  222   * @offset: offset of the register for configuring the gate.
721c42a3 Thomas Abraham       2013-03-09  223   * @bit_idx: bit index of the gate control bit-field in @reg.
721c42a3 Thomas Abraham       2013-03-09  224   * @gate_flags: flags for gate-type clock.
721c42a3 Thomas Abraham       2013-03-09  225   * @alias: optional clock alias name to be assigned to this clock.
721c42a3 Thomas Abraham       2013-03-09  226   */
721c42a3 Thomas Abraham       2013-03-09  227  struct samsung_gate_clock {
721c42a3 Thomas Abraham       2013-03-09  228  	unsigned int		id;
721c42a3 Thomas Abraham       2013-03-09  229  	const char		*dev_name;
721c42a3 Thomas Abraham       2013-03-09  230  	const char		*name;
721c42a3 Thomas Abraham       2013-03-09  231  	const char		*parent_name;
721c42a3 Thomas Abraham       2013-03-09  232  	unsigned long		flags;
721c42a3 Thomas Abraham       2013-03-09  233  	unsigned long		offset;
721c42a3 Thomas Abraham       2013-03-09  234  	u8			bit_idx;
721c42a3 Thomas Abraham       2013-03-09  235  	u8			gate_flags;
721c42a3 Thomas Abraham       2013-03-09  236  	const char		*alias;
721c42a3 Thomas Abraham       2013-03-09  237  };
721c42a3 Thomas Abraham       2013-03-09  238  
721c42a3 Thomas Abraham       2013-03-09  239  #define __GATE(_id, dname, cname, pname, o, b, f, gf, a)	\
721c42a3 Thomas Abraham       2013-03-09  240  	{							\
721c42a3 Thomas Abraham       2013-03-09  241  		.id		= _id,				\
721c42a3 Thomas Abraham       2013-03-09  242  		.dev_name	= dname,			\
721c42a3 Thomas Abraham       2013-03-09  243  		.name		= cname,			\
721c42a3 Thomas Abraham       2013-03-09  244  		.parent_name	= pname,			\
721c42a3 Thomas Abraham       2013-03-09  245  		.flags		= f,				\
721c42a3 Thomas Abraham       2013-03-09  246  		.offset		= o,				\
721c42a3 Thomas Abraham       2013-03-09  247  		.bit_idx	= b,				\
721c42a3 Thomas Abraham       2013-03-09  248  		.gate_flags	= gf,				\
721c42a3 Thomas Abraham       2013-03-09  249  		.alias		= a,				\
721c42a3 Thomas Abraham       2013-03-09  250  	}
721c42a3 Thomas Abraham       2013-03-09  251  
721c42a3 Thomas Abraham       2013-03-09  252  #define GATE(_id, cname, pname, o, b, f, gf)			\
721c42a3 Thomas Abraham       2013-03-09  253  	__GATE(_id, NULL, cname, pname, o, b, f, gf, NULL)
721c42a3 Thomas Abraham       2013-03-09  254  
721c42a3 Thomas Abraham       2013-03-09  255  #define GATE_A(_id, cname, pname, o, b, f, gf, a)		\
721c42a3 Thomas Abraham       2013-03-09  256  	__GATE(_id, NULL, cname, pname, o, b, f, gf, a)
721c42a3 Thomas Abraham       2013-03-09  257  
721c42a3 Thomas Abraham       2013-03-09  258  #define GATE_D(_id, dname, cname, pname, o, b, f, gf)		\
721c42a3 Thomas Abraham       2013-03-09  259  	__GATE(_id, dname, cname, pname, o, b, f, gf, NULL)
721c42a3 Thomas Abraham       2013-03-09  260  
721c42a3 Thomas Abraham       2013-03-09  261  #define GATE_DA(_id, dname, cname, pname, o, b, f, gf, a)	\
721c42a3 Thomas Abraham       2013-03-09  262  	__GATE(_id, dname, cname, pname, o, b, f, gf, a)
721c42a3 Thomas Abraham       2013-03-09  263  
721c42a3 Thomas Abraham       2013-03-09  264  #define PNAME(x) static const char *x[] __initdata
721c42a3 Thomas Abraham       2013-03-09  265  
721c42a3 Thomas Abraham       2013-03-09  266  /**
721c42a3 Thomas Abraham       2013-03-09  267   * struct samsung_clk_reg_dump: register dump of clock controller registers.
721c42a3 Thomas Abraham       2013-03-09  268   * @offset: clock register offset from the controller base address.
721c42a3 Thomas Abraham       2013-03-09  269   * @value: the value to be register at offset.
721c42a3 Thomas Abraham       2013-03-09  270   */
721c42a3 Thomas Abraham       2013-03-09  271  struct samsung_clk_reg_dump {
721c42a3 Thomas Abraham       2013-03-09  272  	u32	offset;
721c42a3 Thomas Abraham       2013-03-09  273  	u32	value;
721c42a3 Thomas Abraham       2013-03-09  274  };
721c42a3 Thomas Abraham       2013-03-09  275  
07dc76fa Yadwinder Singh Brar 2013-06-11  276  /**
07dc76fa Yadwinder Singh Brar 2013-06-11  277   * struct samsung_pll_clock: information about pll clock
07dc76fa Yadwinder Singh Brar 2013-06-11  278   * @id: platform specific id of the clock.
07dc76fa Yadwinder Singh Brar 2013-06-11  279   * @dev_name: name of the device to which this clock belongs.
07dc76fa Yadwinder Singh Brar 2013-06-11  280   * @name: name of this pll clock.
07dc76fa Yadwinder Singh Brar 2013-06-11  281   * @parent_name: name of the parent clock.
07dc76fa Yadwinder Singh Brar 2013-06-11  282   * @flags: optional flags for basic clock.
07dc76fa Yadwinder Singh Brar 2013-06-11  283   * @con_offset: offset of the register for configuring the PLL.
07dc76fa Yadwinder Singh Brar 2013-06-11  284   * @lock_offset: offset of the register for locking the PLL.
07dc76fa Yadwinder Singh Brar 2013-06-11  285   * @type: Type of PLL to be registered.
07dc76fa Yadwinder Singh Brar 2013-06-11  286   * @alias: optional clock alias name to be assigned to this clock.
07dc76fa Yadwinder Singh Brar 2013-06-11  287   */
07dc76fa Yadwinder Singh Brar 2013-06-11  288  struct samsung_pll_clock {
07dc76fa Yadwinder Singh Brar 2013-06-11  289  	unsigned int		id;
07dc76fa Yadwinder Singh Brar 2013-06-11  290  	const char		*dev_name;
07dc76fa Yadwinder Singh Brar 2013-06-11  291  	const char		*name;
07dc76fa Yadwinder Singh Brar 2013-06-11  292  	const char		*parent_name;
07dc76fa Yadwinder Singh Brar 2013-06-11  293  	unsigned long		flags;
07dc76fa Yadwinder Singh Brar 2013-06-11  294  	int			con_offset;
07dc76fa Yadwinder Singh Brar 2013-06-11  295  	int			lock_offset;
07dc76fa Yadwinder Singh Brar 2013-06-11  296  	enum samsung_pll_type	type;
3ff6e0d8 Yadwinder Singh Brar 2013-06-11  297  	const struct samsung_pll_rate_table *rate_table;
07dc76fa Yadwinder Singh Brar 2013-06-11  298  	const char              *alias;
07dc76fa Yadwinder Singh Brar 2013-06-11  299  };
07dc76fa Yadwinder Singh Brar 2013-06-11  300  
3ff6e0d8 Yadwinder Singh Brar 2013-06-11  301  #define __PLL(_typ, _id, _dname, _name, _pname, _flags, _lock, _con,	\
3ff6e0d8 Yadwinder Singh Brar 2013-06-11  302  		_rtable, _alias)					\
07dc76fa Yadwinder Singh Brar 2013-06-11  303  	{								\
07dc76fa Yadwinder Singh Brar 2013-06-11  304  		.id		= _id,					\
07dc76fa Yadwinder Singh Brar 2013-06-11  305  		.type		= _typ,					\
07dc76fa Yadwinder Singh Brar 2013-06-11  306  		.dev_name	= _dname,				\
07dc76fa Yadwinder Singh Brar 2013-06-11  307  		.name		= _name,				\
07dc76fa Yadwinder Singh Brar 2013-06-11  308  		.parent_name	= _pname,				\
07dc76fa Yadwinder Singh Brar 2013-06-11 @309  		.flags		= CLK_GET_RATE_NOCACHE,			\
07dc76fa Yadwinder Singh Brar 2013-06-11  310  		.con_offset	= _con,					\
07dc76fa Yadwinder Singh Brar 2013-06-11  311  		.lock_offset	= _lock,				\
3ff6e0d8 Yadwinder Singh Brar 2013-06-11  312  		.rate_table	= _rtable,				\

:::::: The code at line 142 was first introduced by commit
:::::: 819c1de344c5b8350bffd35be9a0fa74541292d3 clk: add CLK_SET_RATE_NO_REPARENT flag

:::::: TO: James Hogan <james.hogan@imgtec.com>
:::::: CC: Mike Turquette <mturquette@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 40456 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160217/701f7c6c/attachment-0001.obj>
