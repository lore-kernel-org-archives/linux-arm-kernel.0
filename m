From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 07 Feb 2014 16:06:37 +0100
Subject: [PATCH v3 2/5] clk: sunxi: Add USB clock register defintions
In-Reply-To: <20140207144441.GK3192@lukather>
References: <1391783553-8096-1-git-send-email-hdegoede@redhat.com>
 <1391783553-8096-3-git-send-email-hdegoede@redhat.com>
 <20140207144441.GK3192@lukather>
Message-ID: <52F4F67D.7080407@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/07/2014 03:44 PM, Maxime Ripard wrote:
> Hi,
>
> On Fri, Feb 07, 2014 at 03:32:30PM +0100, Hans de Goede wrote:
>> From: Roman Byshko <rbyshko@gmail.com>
>>
>> Add register definitions for the usb-clk register found on sun4i, sun5i and
>> sun7i SoCs.
>>
>> Signed-off-by: Roman Byshko <rbyshko@gmail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   Documentation/devicetree/bindings/clock/sunxi.txt |  5 +++++
>>   drivers/clk/sunxi/clk-sunxi.c                     | 12 ++++++++++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
>> index 27f19f1..e368a86c 100644
>> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
>> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
>> @@ -38,6 +38,8 @@ Required properties:
>>   	"allwinner,sun4i-mod0-clk" - for the module 0 family of clocks
>>   	"allwinner,sun7i-a20-out-clk" - for the external output clocks
>>   	"allwinner,sun7i-a20-gmac-clk" - for the GMAC clock module on A20/A31
>> +	"allwinner,sun4i-usb-clk" - for usb gates + resets on A10 / A20
>
> I know I asked you otherwise, but since we're moving to sun4i-a10-*
> compatibles, can you do it here too ? :)

Sure can do, v4 coming up.

Regards,

Hans
