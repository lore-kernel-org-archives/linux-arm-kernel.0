From: menon.nishanth@gmail.com (Nishanth Menon)
Date: Tue, 01 Dec 2015 10:07:45 -0600
Subject: [PATCH] reset: Introduce static inline dummy function when
 CONFIG_RESET_CONTROLLER
In-Reply-To: <201512012339.srrujPao%fengguang.wu@intel.com>
References: <201512012339.srrujPao%fengguang.wu@intel.com>
Message-ID: <565DC5D1.2080809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/2015 09:56 AM, kbuild test robot wrote:
> Hi Nishanth,
> 
> [auto build test ERROR on v4.4-rc3]
> [also build test ERROR on next-20151127]
> 
> url:    https://github.com/0day-ci/linux/commits/Nishanth-Menon/reset-Introduce-static-inline-dummy-function-when-CONFIG_RESET_CONTROLLER/20151201-233708
> config: i386-randconfig-n0-201548 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/reset/core.c:18:0:
>>> include/linux/reset-controller.h:1:0: error: unterminated #ifndef
>     #ifndef _LINUX_RESET_CONTROLLER_H_
>     ^

Uggh.. thanks kbot... :).. my bad.. last minute whitespace editscan end
up deleting #endifs  :(

While at it, will fix $subject as well.

-- 
Regards,
Nishanth Menon
