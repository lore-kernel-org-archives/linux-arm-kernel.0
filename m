From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 4 Dec 2013 23:40:13 +0530
Subject: [PATCH v4 0/5] Update Davinci watchdog driver
In-Reply-To: <5298943D.8010608@ti.com>
References: <1385556508-3935-1-git-send-email-ivan.khoronzhuk@ti.com>
 <5298943D.8010608@ti.com>
Message-ID: <529F7005.9010904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2013 6:48 PM, Grygorii Strashko wrote:
> Hi Sekhar,
> 
> On 11/27/2013 02:48 PM, Ivan Khoronzhuk wrote:
>> These patches are intended to update Davinci watchdog to use WDT core
>> and reuse driver for keystone arch, because Keystone uses the similar
>> IP like Davinci.
>>
>> See Documentation:
>> Davinci DM646x - http://www.ti.com/lit/ug/spruer5b/spruer5b.pdf
>> Keystone - http://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf
>>
>> Also:
>>   - improved to support GET_TIMELEFT option.
>>   - added "clocks" and "timeout-sec" properties to DT.
> 
> Do you have any additional comments to this series?

I have one comment I just sent out and apart from that the series looks
good to go from my side.

> 
> By the way patch "[PATCH] watchdog: davinci: rename platform driver to davinci-wdt"
> https://lkml.org/lkml/2013/11/27/201 can be applied as before as after this series
> without conflicts.

Yes, I want to queue it from DaVinci tree just because of the amount of
DaVinci code that patch touches, but need ack from Wim before I do that.

Thanks,
Sekhar
