From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 21 Dec 2015 09:54:34 +0200
Subject: [PATCH 0/8] Add support for CL-SOM-iMX7 and SBC-iMX7
In-Reply-To: <20151221064115.GC4703@tiger>
References: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
 <20151214024715.GD25756@tiger> <5671707E.5000908@compulab.co.il>
 <20151221064115.GC4703@tiger>
Message-ID: <5677B03A.2090300@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21/15 08:41, Shawn Guo wrote:
> On Wed, Dec 16, 2015 at 04:09:02PM +0200, Igor Grinberg wrote:
>> Hi Shawn,
>>
>> On 12/14/15 04:47, Shawn Guo wrote:
>>> On Mon, Dec 07, 2015 at 09:14:31AM +0200, Ilya Ledvich wrote:
>>>> Ilya Ledvich (8):
>>>>   ARM: dts: imx7d: cl-som-imx7: add basic module support
>>>>   ARM: dts: imx7d: cl-som-imx7: add usb otg support
>>>>   ARM: dts: imx7d: cl-som-imx7: add eMMC support
>>>>   ARM: dts: imx7d: cl-som-imx7: add fec1 support
>>>>   ARM: dts: imx7d: cl-som-imx7: add eeprom support
>>>>   ARM: dts: imx7d: cl-som-imx7: add gpio extender support
>>>>   ARM: dts: imx7d: cl-som-imx7: add fec2 support
>>>
>>> For the initial board support submission, it doesn't really need such
>>> splitting.  Please merge above patches into one.
>>
>> Yeah, I know there is no need for such splitting, yet I think
>> if the splitting is done right - it is much simpler to review,
> 
> Not really for a initial board support.
> 
>> it provides a better bisectability (in case it will be needed in
>> the future),
> 
> This is an initial board support submission and all the devices added
> there should be functional.  The bisectability shouldn't needed in this
> case.
> 
>> and also if for some reason one (or more) patches are
>> needing some time consuming rework, others (earlier ones in the series)
>> can be accepted meanwhile.
> 
> It's not really the case for this series.

I'm glad you think so :-)

> 
>>
>> So, I really like to keep it this way, unless you insist.
> 
> Please merge them.

Ok.


-- 
Regards,
Igor.
