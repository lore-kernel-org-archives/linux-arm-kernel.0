From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 7 Nov 2012 15:44:01 -0600
Subject: [PATCH V2 00/14] ARM: OMAP: DMTIMER fixes
In-Reply-To: <20121107212254.GK6801@atomide.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
 <20121107212254.GK6801@atomide.com>
Message-ID: <509AD621.7060402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/07/2012 03:22 PM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [121107 11:03]:
>> This series includes several fixes for the OMAP DMTIMER driver. This is
>> based upon 3.7-rc4 with the two series adding device-tree support for
>> DMTIMERs [1] and the 32kHz Counter [2]
> 
> These look OK to me, I'm assuming you'll do a pull request eventually
> for these. Might be worth checking if these merge fine also on
> omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3, rename detection
> might be able to deal with that for the header.

Yes I was going to wait a few days for people to review before sending a
pull request. I will make sure it merges on your master. Is Monday too
late for v3.8?

Cheers
Jon

>> [1] http://marc.info/?l=linux-omap&m=135065875808614&w=2
>> [2] http://marc.info/?l=linux-omap&m=135119308123513&w=2
