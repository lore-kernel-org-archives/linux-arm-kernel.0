From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Tue, 10 Dec 2013 16:53:53 +0200
Subject: [PATCH 2/2] arm: keystone: enable watchdog support
In-Reply-To: <1386686869-729-2-git-send-email-ivan.khoronzhuk@ti.com>
References: <1386686869-729-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1386686869-729-2-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <52A72B01.9090305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ CC
devicetree at vger.kernel.org
linux-arm-kernel at lists.infradead.org
linux-kernel at vger.kernel.org

On 12/10/2013 04:47 PM, Ivan Khoronzhuk wrote:
> After Keystone watchdog driver updates are already merged we can
> enable WDT in config.
>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
> Based on
> git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
> keystone/master
>
>   arch/arm/configs/keystone_defconfig |    2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
> index 9943e5d..8bd940c 100644
> --- a/arch/arm/configs/keystone_defconfig
> +++ b/arch/arm/configs/keystone_defconfig
> @@ -129,6 +129,8 @@ CONFIG_SPI_DAVINCI=y
>   CONFIG_SPI_SPIDEV=y
>   # CONFIG_HWMON is not set
>   CONFIG_WATCHDOG=y
> +CONFIG_WATCHDOG_CORE=y
> +CONFIG_DAVINCI_WATCHDOG=y
>   # CONFIG_USB_SUPPORT is not set
>   CONFIG_DMADEVICES=y
>   CONFIG_COMMON_CLK_DEBUG=y
>


-- 
Regards,
Ivan Khoronzhuk
