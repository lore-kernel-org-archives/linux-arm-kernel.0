From: jassisinghbrar@gmail.com (jassi brar)
Date: Thu, 28 Jan 2010 17:13:01 +0900
Subject: [PATCH] ARM: S3C64XX: SPI: Make platform device build selectable
In-Reply-To: <20100128080525.GT10014@trinity.fluff.org>
References: <1264663530-30027-1-git-send-email-jassisinghbrar@gmail.com>
	<20100128080525.GT10014@trinity.fluff.org>
Message-ID: <1b68c6791001280013t2688b6b4pe22f97ed9144bee9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 5:05 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Thu, Jan 28, 2010 at 04:25:30PM +0900, jassisinghbrar at gmail.com wrote:
>> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
>> index 1c2fe91..2220187 100644
>> --- a/arch/arm/plat-samsung/Kconfig
>> +++ b/arch/arm/plat-samsung/Kconfig
>> @@ -132,6 +132,11 @@ config S3C_DEV_NAND
>> ? ? ? help
>> ? ? ? ? Compile in platform device definition for NAND controller
>>
>> +config S3C_DEV_SPI
>
> I'd prefer to see this as either S3C64XX_DEV_SPI or S3C_DEV_HSSPI to
> differentiate it from the older S3C24XX SPI blocks.
I prefer S3C64XX_DEV_SPI.
will resend. thanks.
