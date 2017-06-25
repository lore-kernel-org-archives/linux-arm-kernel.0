From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Sun, 25 Jun 2017 14:19:55 -0700
Subject: [PATCH 0/4] Davinci remoteproc cleanups/fixes
In-Reply-To: <20170518220902.2846-1-s-anna@ti.com>
References: <20170518220902.2846-1-s-anna@ti.com>
Message-ID: <20170625211955.GD26155@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 18 May 15:08 PDT 2017, Suman Anna wrote:

> Hi Bjorn,
> 
> The following series includes various fixes and cleanups for the TI's
> Davinci DSP remoteproc driver. Patches are based on 4.12-rc1. Following
> is the patch summary:
> 
>  - Patch1 updates/fixes the build dependency on DMA_CMA which is not
>    selected by default in the davinci_defconfig.
>  - Patch 3 fixes a DSP boot/functionality issue with repeated 'start'
>    and 'stop' commands using the sysfs 'state' variable.
>  - Patch 2 and 4 are cleanups/code simplifications.
> 

Patches 1, 2 and 3 applied to rproc-next.

Regards,
Bjorn
