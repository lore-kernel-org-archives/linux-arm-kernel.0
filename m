From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 8 Dec 2011 08:28:58 +0100
Subject: [PATCH] ARM: imx6q: generate imx6q dtb files
In-Reply-To: <20111208072011.GA7913@S2100-06.ap.freescale.net>
References: <1323269051-29007-1-git-send-email-eric.miao@linaro.org>
 <20111208072011.GA7913@S2100-06.ap.freescale.net>
Message-ID: <4EE0673A.7040500@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.12.2011 08:20, Shawn Guo wrote:
> Hi Eric,
> 
> On Wed, Dec 07, 2011 at 10:44:11PM +0800, Eric Miao wrote:
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Signed-off-by: Eric Miao <eric.miao@linaro.org>
>> ---
>>  arch/arm/mach-imx/Makefile.boot |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
>> index cfede57..67b76f5 100644
>> --- a/arch/arm/mach-imx/Makefile.boot
>> +++ b/arch/arm/mach-imx/Makefile.boot
>> @@ -25,3 +25,6 @@ initrd_phys-$(CONFIG_SOC_IMX35)	:= 0x80800000
>>  zreladdr-$(CONFIG_SOC_IMX6Q)	+= 0x10008000
>>  params_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10000100
>>  initrd_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10800000
>> +
>> +dtb-$(CONFIG_SOC_IMX6Q)	+= imx6q-sabreauto.dtb \
>> +			   imx6q-sabrelite.dtb
> 
> We do not have imx6q-sabrelite.dts hit mainline yet.

Same mistake I made yesterday ;)

Anyway, maybe we should somehow sync this with

http://lists.arm.linux.org.uk/lurker/message/20111208.072201.a76a6a41.en.html

?

Maybe put these two patches in a 1/2 and 2/2 patch series?

Best regards

Dirk
