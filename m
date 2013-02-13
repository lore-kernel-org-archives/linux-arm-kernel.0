From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 13 Feb 2013 23:03:01 +0530
Subject: [GIT PULL] DaVinci DT updates for v3.9 (part 2)
In-Reply-To: <20130210012707.GL16278@quad.lixom.net>
References: <51168E50.1010709@ti.com> <20130210012707.GL16278@quad.lixom.net>
Message-ID: <511BCE4D.2060602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 2/10/2013 6:57 AM, Olof Johansson wrote:
> On Sat, Feb 09, 2013 at 11:28:40PM +0530, Sekhar Nori wrote:
>> Hi Arnd, Olof,
>>
>> Can you please pull the following changes for v3.9?
>>
>> Thanks,
>> Sekhar
>>
>> The following changes since commit 1661636d362b6d1a6c2bab210f2ab363a69deccc:
>>
>>   ARM: davinci: da850: add RTC DT entries (2013-01-28 21:28:11 +0530)
>>
>> are available in the git repository at:
>>
>>   git://gitorious.org/linux-davinci/linux-davinci.git tags/davinci-for-v3.9/dt-2
> 
> Pulled, but:
> 
>> Kumar, Anil (2):
>>       ARM: davinci: da850 DT: add support for machine reboot
> 
> Looking at this patch, looking for any device named "watchdog" seems a
> bit fragile.  It's an unfortunate device name to have it that generic
> in the davinci_wdt driver.

Yes, agreed. Ideally a future patch should fix that but I wonder if
device name becomes part of userspace API because it gets exposed
through sysfs and hence should not be changed?

Thanks,
Sekhar
