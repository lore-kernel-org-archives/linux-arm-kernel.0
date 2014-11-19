From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 19 Nov 2014 11:39:18 +0530
Subject: [PATCH 1/2] phy: berlin_usb: depends on RESET_CONTROLLER
In-Reply-To: <546BA05E.4090605@gmail.com>
References: <1416231192-27056-1-git-send-email-antoine.tenart@free-electrons.com>
 <1416231192-27056-2-git-send-email-antoine.tenart@free-electrons.com>
 <546BA05E.4090605@gmail.com>
Message-ID: <546C340E.8000209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 19 November 2014 01:09 AM, Sebastian Hesselbarth wrote:
> On 17.11.2014 14:33, Antoine Tenart wrote:
>> The Berlin USB PHY driver uses the Berlin reset controller
>> unconditionally. Make it depending on RESET_CONTROLLER.
>>
>> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> 
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> 
>> ---
>>   drivers/phy/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>> index b6da75f563e7..38ca6ff00aef 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -17,7 +17,7 @@ config GENERIC_PHY
>>
>>   config PHY_BERLIN_USB

phy-berlin-usb is not in my phy tree and I don't seem to find anywhere in my
inbox. Care to send them to me?

Thanks
Kishon
