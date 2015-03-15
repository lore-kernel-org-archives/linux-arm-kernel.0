From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 15 Mar 2015 21:15:56 +0800
Subject: [PATCH 09/10] ARM: zx: Add basic defconfig support to ZX296702
In-Reply-To: <1426333785-3952-10-git-send-email-jun.nie@linaro.org>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
 <1426333785-3952-10-git-send-email-jun.nie@linaro.org>
Message-ID: <20150315131554.GD20455@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 14, 2015 at 07:49:44PM +0800, Jun Nie wrote:
> Add basic defconfig support to zx SOC, including uart, mmc
>  and other common config
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  arch/arm/configs/zx_defconfig | 129 ++++++++++++++++++++++++++++++++++++++++++

I see a warning with make zx_defconfig.

arch/arm/configs/zx_defconfig:121:warning: override: reassigning to symbol DEBUG_PREEMPT

Shawn
