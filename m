From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 Mar 2016 13:26:22 +0000
Subject: [PATCH] MAINTAINERS: Add the stlinux kernel mailing list for the
 STi drm driver.
In-Reply-To: <1458213210-13873-1-git-send-email-peter.griffin@linaro.org>
References: <1458213210-13873-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160317132622.GB13692@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Mar 2016, Peter Griffin wrote:

> Most drivers for STi are under the ARM/STI Architecture section which
> includes this mailing list.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6ee06ea..c541a89 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3814,6 +3814,7 @@ DRM DRIVERS FOR STI
>  M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
>  M:	Vincent Abriou <vincent.abriou@st.com>
>  L:	dri-devel at lists.freedesktop.org
> +L:	kernel at stlinux.com
>  T:	git http://git.linaro.org/people/benjamin.gaignard/kernel.git
>  S:	Maintained
>  F:	drivers/gpu/drm/sti

Doesn't it make more sense to add drivers/gpu/drm/sti/ to the ARM/STI
ARCHITECTURE list of supported files?

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a1a569..78201c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1505,6 +1505,7 @@ F:        arch/arm/mach-sti/
 F:     arch/arm/boot/dts/sti*
 F:     drivers/clocksource/arm_global_timer.c
 F:     drivers/i2c/busses/i2c-st.c
+F:     drivers/gpu/drm/sti/
 F:     drivers/media/rc/st_rc.c
 F:     drivers/mmc/host/sdhci-st.c
 F:     drivers/phy/phy-miphy28lp.c


-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
