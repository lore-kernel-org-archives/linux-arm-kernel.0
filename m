From: gerg@uclinux.org (Greg Ungerer)
Date: Fri, 25 Oct 2013 22:53:37 +1000
Subject: [PATCH 0/8] ARM: imx: add IMX50 SoC support
In-Reply-To: <20131024150050.GA14529@S2101-09.ap.freescale.net>
References: <1382076260-6422-1-git-send-email-gerg@uclinux.org>
 <20131024150050.GA14529@S2101-09.ap.freescale.net>
Message-ID: <526A69D1.80506@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn

On 25/10/13 01:00, Shawn Guo wrote:
> Hi Greg,
>
> On Fri, Oct 18, 2013 at 04:04:12PM +1000, gerg at uclinux.org wrote:
>> From: Greg Ungerer <gerg@uclinux.org>
>>
>> This set of patches is the code and device tree support for the Freescale
>> IMX50 SoC. This part is similar to the IMX53 SoC family, and I have resued
>> as much of its support as possible. These patches are against 3.12-rc5.
>
> Nice patches.  Can you please base it on branch below with your next
> posting, so that I can apply them more easily?
>
>    git://git.linaro.org/people/shawnguo/linux-2.6.git for-next

Sure thing. I'll roll in all your suggestions, and send out a v2 in
the next few days. Thanks for the review.

Regards
Greg



> Shawn
>
>> With these changes you can load and run on the Freescale IMX50-EVK board.
>>
>> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
>> ---
>>   arch/arm/Kconfig.debug              |    9
>>   arch/arm/boot/dts/Makefile          |    1
>>   arch/arm/boot/dts/imx50-evk.dts     |   89 +++
>>   arch/arm/boot/dts/imx50-pinfunc.h   |  923 ++++++++++++++++++++++++++++++++++++
>>   arch/arm/boot/dts/imx50.dtsi        |  659 +++++++++++++++++++++++++
>>   arch/arm/include/debug/imx-uart.h   |   10
>>   arch/arm/mach-imx/Kconfig           |    9
>>   arch/arm/mach-imx/Makefile          |    1
>>   arch/arm/mach-imx/clk-imx51-imx53.c |   79 +++
>>   arch/arm/mach-imx/common.h          |    3
>>   arch/arm/mach-imx/mach-imx50.c      |   52 ++
>>   drivers/pinctrl/Kconfig             |    8
>>   drivers/pinctrl/Makefile            |    1
>>   drivers/pinctrl/pinctrl-imx50.c     |  426 ++++++++++++++++
>>   14 files changed, 2270 insertions(+)
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
