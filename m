From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Tue, 24 Jul 2018 09:09:42 +0900
Subject: [PATCH v5] media: dvb-frontends: add Socionext MN88443x ISDB-S/T
 demodulator driver
In-Reply-To: <201807240508.gpMy7uIR%fengguang.wu@intel.com>
References: <20180723085150.24266-1-suzuki.katsuhiro@socionext.com>
 <201807240508.gpMy7uIR%fengguang.wu@intel.com>
Message-ID: <000001d422e2$9f695260$de3bf720$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ugh, sorry. I'll fix it...

Regards,
--
Katsuhiro Suzuki


> -----Original Message-----
> From: kbuild test robot <lkp@intel.com>
> Sent: Tuesday, July 24, 2018 7:15 AM
> To: Suzuki, Katsuhiro/?? ?? <suzuki.katsuhiro@socionext.com>
> Cc: kbuild-all at 01.org; Mauro Carvalho Chehab <mchehab+samsung@kernel.org>;
> linux-media at vger.kernel.org; Masami Hiramatsu <masami.hiramatsu@linaro.org>;
> Jassi Brar <jaswinder.singh@linaro.org>; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; Suzuki, Katsuhiro/?? ??
> <suzuki.katsuhiro@socionext.com>
> Subject: Re: [PATCH v5] media: dvb-frontends: add Socionext MN88443x ISDB-S/T
> demodulator driver
> 
> Hi Katsuhiro,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linuxtv-media/master]
> [also build test ERROR on v4.18-rc6 next-20180723]
> [if your patch is applied to the wrong git tree, please drop us a note to help
improve
> the system]
> 
> url:
> https://github.com/0day-ci/linux/commits/Katsuhiro-Suzuki/media-dvb-frontends-a
> dd-Socionext-MN88443x-ISDB-S-T-demodulator-driver/20180724-050011
> base:   git://linuxtv.org/media_tree.git master
> config: i386-randconfig-i1-201829 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/media/dvb-frontends/mn88443x.c:15:10: fatal error: sc1501a.h: No
such
> file or directory
>     #include "sc1501a.h"
>              ^~~~~~~~~~~
>    compilation terminated.
> 
> vim +15 drivers/media/dvb-frontends/mn88443x.c
> 
>     14
>   > 15	#include "sc1501a.h"
>     16
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
