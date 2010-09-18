From: nm@ti.com (Nishanth Menon)
Date: Sat, 18 Sep 2010 00:48:54 -0500
Subject: [PATCH v2] power: introduce library for device-specific OPPs
In-Reply-To: <4C945139.20602@ti.com>
References: <1284787459-25643-1-git-send-email-nm@ti.com>
	<20100918053849.GA19709@suse.de> <4C945139.20602@ti.com>
Message-ID: <4C9452C6.8010308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Menon, Nishanth had written, on 09/18/2010 12:42 AM, the following:
> Greg KH had written, on 09/18/2010 12:38 AM, the following:
>> On Sat, Sep 18, 2010 at 12:24:19AM -0500, Nishanth Menon wrote:
>>> This is hence introduced under lib allowing all architectures to
>>> selectively enable the feature based on their capabilities.
>> <snip>
>>
>>>  Documentation/power/00-INDEX |    2 +
>>>  Documentation/power/opp.txt  |  326 ++++++++++++++++++++++++++
>>>  drivers/base/power/Makefile  |    1 +
>>>  drivers/base/power/opp.c     |  527 ++++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/opp.h          |  126 ++++++++++
>>>  kernel/power/Kconfig         |   14 ++
>>>  6 files changed, 996 insertions(+), 0 deletions(-)
>>>  create mode 100644 Documentation/power/opp.txt
>>>  create mode 100644 drivers/base/power/opp.c
>>>  create mode 100644 include/linux/opp.h
>> That doesn't look like the files are under lib/
>>
>> Did you forget to move them, or do you need to update the changelog
>> message?
> 
> Aww... and I thought I fixed them all.. the commit message is wrong.
> we had an alignment earlier today to move it from lib to 
> drivers/base/power [1] :(
> 
> Thanks for catching it. Will fix it in rev 3 after collating any further 
> comments as well.
> 
> [1] http://marc.info/?l=linux-arm-kernel&m=128476405731191&w=2
Yikes..sleepy eyes and long threads don't go well together :(

[1] http://marc.info/?l=linux-arm-kernel&m=128476651001280&w=2 is the 
link I had intended

apologies on the spam.. :(
-- 
Regards,
Nishanth Menon
