From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 26 Dec 2013 12:55:02 -0500
Subject: [PATCH v5 0/5] Update Davinci watchdog driver
In-Reply-To: <52ACAED4.7000305@ti.com>
References: <1386185970-14488-1-git-send-email-ivan.khoronzhuk@ti.com>
 <52A5EF6B.6060700@ti.com> <52ACAED4.7000305@ti.com>
Message-ID: <52BC6D76.7000400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 December 2013 02:17 PM, Santosh Shilimkar wrote:
> Wim,
> 
> On Monday 09 December 2013 11:27 AM, Santosh Shilimkar wrote:
>> Wim,
>>
>> On Wednesday 04 December 2013 02:39 PM, Ivan Khoronzhuk wrote:
>>> These patches are intended to update Davinci watchdog to use WDT core
>>> and reuse driver for keystone arch, because Keystone uses the similar
>>> IP like Davinci.
>>>
>>
>> [..]
>>
>>> v4..v5:
>>> - watchdog: davinci: change driver to use WDT core
>>> 	switched off CONFIG_WATCHDOG_NOWAYOUT option
>>>
>> Can you please apply the series to your watchdog tree ?
>> Do let me know if you want us to prepare a git branch
>> to pull from.
>>
> ping..
> 
I haven't heard anything on this yet from you Wim.

Guenter,
I have seen you actively reviewing the $subject patch series.
Will you be able to pick the series up for 3.14 merge window
considering almost no response from Wim so far on it ?

Regards,
Santosh
