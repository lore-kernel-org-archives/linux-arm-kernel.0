From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 5 May 2015 16:42:25 -0500
Subject: [PATCH v3 5/5] MAINTAINERS: Add pci-st.c to ARCH/STI architecture
In-Reply-To: <1428657168-12495-6-git-send-email-gabriel.fernandez@linaro.org>
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org>
 <1428657168-12495-6-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20150505214225.GC24643@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 11:12:48AM +0200, Gabriel FERNANDEZ wrote:
> This patch adds the pci-st.c pci driver found on STMicroelectronics
> SoC's into the STI arch section of the maintainers file.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>

I'd like an ack from the current maintainers:

  ARM/STI ARCHITECTURE
  M:      Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
  M:      Maxime Coquelin <maxime.coquelin@st.com>
  M:      Patrice Chotard <patrice.chotard@st.com>

that they're OK with taking on this additional file.

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index efbcb50..4639d2d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1468,6 +1468,7 @@ F:	drivers/clocksource/arm_global_timer.c
>  F:	drivers/i2c/busses/i2c-st.c
>  F:	drivers/media/rc/st_rc.c
>  F:	drivers/mmc/host/sdhci-st.c
> +F:	drivers/pci/host/pci-st.c
>  F:	drivers/phy/phy-stih407-usb.c
>  F:	drivers/phy/phy-stih41x-usb.c
>  F:	drivers/pinctrl/pinctrl-st.c
> -- 
> 1.9.1
> 
