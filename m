From: tyler@opensourcefoundries.com (Tyler Baker)
Date: Tue, 5 Dec 2017 12:58:52 -0800
Subject: [PATCH 2/8] ARM: dts: imx7: build imx7d-sbc-iot-imx7 dtb
In-Reply-To: <CAOMZO5AKyYR+AYMpbOokKbkgAbaGAucHtdHrosPOh3wbEHY1sA@mail.gmail.com>
References: <20171130201434.14122-1-tyler@opensourcefoundries.com>
 <20171130201434.14122-3-tyler@opensourcefoundries.com>
 <CAOMZO5AKyYR+AYMpbOokKbkgAbaGAucHtdHrosPOh3wbEHY1sA@mail.gmail.com>
Message-ID: <CAH=dhFQ1F1Dwd-Kx9XXo9_A83J4hzUOue9=LeH+JdbOe_04s8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 1, 2017 at 12:11 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Thu, Nov 30, 2017 at 6:14 PM,  <tyler@opensourcefoundries.com> wrote:
>> From: Tyler Baker <tyler@opensourcefoundries.com>
>>
>> Build the imx7d-sbc-iot-imx7 device tree blob.
>>
>> Signed-off-by: Tyler Baker <tyler@opensourcefoundries.com>
>> ---
>>  arch/arm/boot/dts/Makefile | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index d0381e9..0334137 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -515,6 +515,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
>>         imx7d-nitrogen7.dtb \
>>         imx7d-pico.dtb \
>>         imx7d-sbc-imx7.dtb \
>> +       imx7d-sbc-iot-imx7.dtb \
>
> This could be part of the previous patch that introduces the dts.

Ok will do.
