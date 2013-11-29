From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 29 Nov 2013 09:57:29 -0500
Subject: [PATCH v4 0/5] Update Davinci watchdog driver
In-Reply-To: <5298943D.8010608@ti.com>
References: <1385556508-3935-1-git-send-email-ivan.khoronzhuk@ti.com>
 <5298943D.8010608@ti.com>
Message-ID: <5298AB59.7020506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 November 2013 08:18 AM, Grygorii Strashko wrote:
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
> 
> By the way patch "[PATCH] watchdog: davinci: rename platform driver to davinci-wdt"
> https://lkml.org/lkml/2013/11/27/201 can be applied as before as after this series
> without conflicts.
> 
Thats good then and probably the series can go via watchdog tree.
In either way, it will be good to know who is queuing up the series for 3.14

Regards,
Santosh
