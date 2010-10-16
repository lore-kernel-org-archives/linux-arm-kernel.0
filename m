From: baruch@tkos.co.il (Baruch Siach)
Date: Sat, 16 Oct 2010 20:33:51 +0200
Subject: [PATCH v2 2/5] mx25: add defconfig
In-Reply-To: <1287137707-9548-2-git-send-email-eric@eukrea.com>
References: <20101015070731.GF6747@pengutronix.de>
	<1287137707-9548-2-git-send-email-eric@eukrea.com>
Message-ID: <20101016183350.GB6225@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Fri, Oct 15, 2010 at 12:15:04PM +0200, Eric B?nard wrote:
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
>  arch/arm/configs/mx25_defconfig |  159 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 159 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/configs/mx25_defconfig
> 
> diff --git a/arch/arm/configs/mx25_defconfig b/arch/arm/configs/mx25_defconfig
> new file mode 100644
> index 0000000..25aa600
> --- /dev/null
> +++ b/arch/arm/configs/mx25_defconfig
> @@ -0,0 +1,159 @@

[snip]

> +CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_PCF8563=y

Shouldn't we enable CONFIG_RTC_DRV_IMXDI as well? This is the on-chip DryIce 
RTC.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
