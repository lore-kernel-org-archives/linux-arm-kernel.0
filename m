From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 Jul 2013 18:22:02 -0300
Subject: [PATCH 01/22] ARM i.MX25: devicetree: add compatible property for
 imxfb support.
In-Reply-To: <20130715211621.GA10995@pengutronix.de>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
 <1373900227-341-2-git-send-email-denis@eukrea.com>
 <20130715211621.GA10995@pengutronix.de>
Message-ID: <CAOMZO5A0qS39GFf1PeFS7BBL7PFMbNjkNpD2yqKGg660ZyYxbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 6:16 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Mon, Jul 15, 2013 at 04:56:46PM +0200, Denis Carikli wrote:
>> Signed-off-by: Denis Carikli <denis@eukrea.com>
>> ---
>>  arch/arm/boot/dts/imx25.dtsi |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
>> index bcd3171..6a1633d 100644
>> --- a/arch/arm/boot/dts/imx25.dtsi
>> +++ b/arch/arm/boot/dts/imx25.dtsi
>> @@ -394,6 +394,7 @@
>>                       };
>>
>>                       lcdc at 53fbc000 {
>> +                             compatible = "fsl,imx21-lcdif";
>
> The driver matches "fsl,imx21-fb", not "fsl,imx21-lcdif". Also please
> add a i.MX25 specific compatible so that we have the chance to match the
> specific SoC version in the driver.

A patch was already sent for this:
http://www.spinics.net/lists/arm-kernel/msg258249.html
