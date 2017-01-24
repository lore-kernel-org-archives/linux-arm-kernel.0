From: lkp@intel.com (kbuild test robot)
Date: Tue, 24 Jan 2017 08:36:48 +0800
Subject: [alsa-devel] [PATCH 2/7] MFD: add STM32 DFSDM support
In-Reply-To: <1485189145-29576-3-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <201701240854.DIwrD2gU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

[auto build test WARNING on iio/togreg]
[cannot apply to asoc/for-next ljones-mfd/for-mfd-next v4.10-rc5 next-20170123]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Arnaud-Pouliquen/Add-STM32-DFSDM-support/20170124-065537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/linux/linkage.h:6:0,
                    from include/linux/kernel.h:6,
                    from include/linux/clk.h:16,
                    from drivers/mfd/stm32-dfsdm.c:19:
   drivers/mfd/stm32-dfsdm.c:397:19: error: 'dfsdm_configure_filter' undeclared here (not in a function)
    EXPORT_SYMBOL_GPL(dfsdm_configure_filter);
                      ^
   include/linux/export.h:58:16: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;      \
                   ^~~
>> drivers/mfd/stm32-dfsdm.c:397:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(dfsdm_configure_filter);
    ^~~~~~~~~~~~~~~~~
   drivers/mfd/stm32-dfsdm.c:426:19: error: 'dfsdm_start_filter' undeclared here (not in a function)
    EXPORT_SYMBOL_GPL(dfsdm_start_filter);
                      ^
   include/linux/export.h:58:16: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;      \
                   ^~~
   drivers/mfd/stm32-dfsdm.c:426:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(dfsdm_start_filter);
    ^~~~~~~~~~~~~~~~~
   drivers/mfd/stm32-dfsdm.c:444:19: error: 'dfsdm_stop_filter' undeclared here (not in a function)
    EXPORT_SYMBOL_GPL(dfsdm_stop_filter);
                      ^
   include/linux/export.h:58:16: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;      \
                   ^~~
   drivers/mfd/stm32-dfsdm.c:444:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(dfsdm_stop_filter);
    ^~~~~~~~~~~~~~~~~
   drivers/mfd/stm32-dfsdm.c:470:19: error: 'dfsdm_read_fl_conv' undeclared here (not in a function)
    EXPORT_SYMBOL_GPL(dfsdm_read_fl_conv);
                      ^
   include/linux/export.h:58:16: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;      \
                   ^~~
   drivers/mfd/stm32-dfsdm.c:470:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(dfsdm_read_fl_conv);
    ^~~~~~~~~~~~~~~~~
   drivers/mfd/stm32-dfsdm.c:500:19: error: 'dfsdm_get_filter' undeclared here (not in a function)
    EXPORT_SYMBOL_GPL(dfsdm_get_filter);
                      ^
   include/linux/export.h:58:16: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;      \
                   ^~~
   drivers/mfd/stm32-dfsdm.c:500:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(dfsdm_get_filter);
    ^~~~~~~~~~~~~~~~~
   drivers/mfd/stm32-dfsdm.c:518:19: error: 'dfsdm_release_filter' undeclared here (not in a function)
    EXPORT_SYMBOL_GPL(dfsdm_release_filter);
                      ^
   include/linux/export.h:58:16: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;      \
                   ^~~
   drivers/mfd/stm32-dfsdm.c:518:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(dfsdm_release_filter);
    ^~~~~~~~~~~~~~~~~
   drivers/mfd/stm32-dfsdm.c:603:19: error: 'dfsdm_register_fl_event' undeclared here (not in a function)
    EXPORT_SYMBOL_GPL(dfsdm_register_fl_event);
                      ^
   include/linux/export.h:58:16: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;      \
                   ^~~
   drivers/mfd/stm32-dfsdm.c:603:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(dfsdm_register_fl_event);
    ^~~~~~~~~~~~~~~~~
   drivers/mfd/stm32-dfsdm.c:666:19: error: 'dfsdm_unregister_fl_event' undeclared here (not in a function)
    EXPORT_SYMBOL_GPL(dfsdm_unregister_fl_event);
                      ^
   include/linux/export.h:58:16: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;      \
                   ^~~
   drivers/mfd/stm32-dfsdm.c:666:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(dfsdm_unregister_fl_event);
    ^~~~~~~~~~~~~~~~~
   drivers/mfd/stm32-dfsdm.c:729:19: error: 'dfsdm_start_channel' undeclared here (not in a function)
    EXPORT_SYMBOL_GPL(dfsdm_start_channel);
                      ^
   include/linux/export.h:58:16: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;      \
                   ^~~
   drivers/mfd/stm32-dfsdm.c:729:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(dfsdm_start_channel);
    ^~~~~~~~~~~~~~~~~
   drivers/mfd/stm32-dfsdm.c:755:19: error: 'dfsdm_stop_channel' undeclared here (not in a function)
    EXPORT_SYMBOL_GPL(dfsdm_stop_channel);
                      ^
   include/linux/export.h:58:16: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;      \
                   ^~~
   drivers/mfd/stm32-dfsdm.c:755:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(dfsdm_stop_channel);
    ^~~~~~~~~~~~~~~~~
   drivers/mfd/stm32-dfsdm.c:825:19: error: 'dfsdm_get_channel' undeclared here (not in a function)
    EXPORT_SYMBOL_GPL(dfsdm_get_channel);
                      ^
   include/linux/export.h:58:16: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;      \
                   ^~~
   drivers/mfd/stm32-dfsdm.c:825:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(dfsdm_get_channel);
    ^~~~~~~~~~~~~~~~~
   drivers/mfd/stm32-dfsdm.c:843:19: error: 'dfsdm_release_channel' undeclared here (not in a function)
    EXPORT_SYMBOL_GPL(dfsdm_release_channel);
                      ^
   include/linux/export.h:58:16: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;      \
                   ^~~
   drivers/mfd/stm32-dfsdm.c:843:1: note: in expansion of macro 'EXPORT_SYMBOL_GPL'
    EXPORT_SYMBOL_GPL(dfsdm_release_channel);

vim +/EXPORT_SYMBOL_GPL +397 drivers/mfd/stm32-dfsdm.c

   381		DFSDM_UPDATE_BITS(priv->regmap, DFSDM_FCR(fl_id), DFSDM_FCR_FOSR_MASK,
   382				  DFSDM_FCR_FOSR((sparams->oversampling - 1)));
   383	
   384		DFSDM_UPDATE_BITS(priv->regmap, DFSDM_FCR(fl_id), DFSDM_FCR_FORD_MASK,
   385				  DFSDM_FCR_FORD(sparams->order));
   386	
   387		/* Conversion */
   388		if (fl_cfg->inj_params)
   389			stm32_dfsdm_configure_inj_conv(priv, fl_id, fl_cfg->inj_params);
   390		else if (fl_cfg->reg_params)
   391			stm32_dfsdm_configure_reg_conv(priv, fl_id, fl_cfg->reg_params);
   392	
   393		priv->filters[fl_id].event = fl_cfg->event;
   394	
   395		return 0;
   396	}
 > 397	EXPORT_SYMBOL_GPL(dfsdm_configure_filter);
   398	
   399	/**
   400	 * stm32_dfsdm_start_filter - Start filter conversion.
   401	 *
   402	 * @dfsdm: Handle used to retrieve dfsdm context.
   403	 * @fl_id: Filter id.
   404	 * @conv: Conversion type regular or injected.
   405	 */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57000 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170124/150c0b19/attachment-0001.gz>
