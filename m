From: olof@lixom.net (Olof Johansson)
Date: Tue, 10 Sep 2013 08:20:24 -0700
Subject: [PATCH 07/38] ARM: ux500: CONFIG: Enable ST's IIO Accelerometer
 Sensors by default
In-Reply-To: <1378817379-8238-8-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-8-git-send-email-lee.jones@linaro.org>
Message-ID: <CAOesGMj+YzkE5bAxUqFYWoJ-RURDdCK5MUWYTc+gWFQMB3KWkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 5:49 AM, Lee Jones <lee.jones@linaro.org> wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/configs/u8500_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
> index 6b29109..24f88d6 100644
> --- a/arch/arm/configs/u8500_defconfig
> +++ b/arch/arm/configs/u8500_defconfig
> @@ -39,6 +39,7 @@ CONFIG_BLK_DEV_RAM_SIZE=65536
>  CONFIG_SENSORS_BH1780=y
>  CONFIG_IIO=y
>  CONFIG_IIO_ST_PRESS=y
> +CONFIG_IIO_ST_ACCEL_3AXIS=y
>  CONFIG_NETDEVICES=y
>  CONFIG_SMSC911X=y
>  CONFIG_SMSC_PHY=y

This is ridiculous.

I know lwn.net's patch author statistics are fun to be on, but
splitting this and the other config update into two patches? Really?


-Olof
