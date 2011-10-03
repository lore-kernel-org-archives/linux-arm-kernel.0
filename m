From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 03 Oct 2011 15:12:32 +0530
Subject: [PATCH 00/30] ARM/omap: omap specific randconfig fixes
In-Reply-To: <7246478.IyGHQ24uSq@wuerfel>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<4E894295.5000608@ti.com> <7246478.IyGHQ24uSq@wuerfel>
Message-ID: <4E898388.40601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 October 2011 02:52 PM, Arnd Bergmann wrote:
> On Monday 03 October 2011 10:35:25 Santosh Shilimkar wrote:
> 
>>> The entire set is also available from
>>>  git pull git://git.linaro.org/people/arnd/arm-soc.git randconfig/omap
>>>
>>> but I have not yet pulled them into the for-next branch.
>>>
>> Do you have any scripts to create these randconfigs ?
>> These are useful to run on newer set of patches also to get all
>> builds right first place.
> 
> Yes, see the for-next+randconfig branch of
> git://git.linaro.org/people/arnd/arm-soc.git. It has all my patches
> and a randconfig.sh script.
> 
> Right now, I'm trying to get a baseline upstream, since I have around 150
> patches that are needed to always build ten platforms successfully.
>
Ok. Will have a look at it.

> The main problem is that you basically need all the patches I did in order
> to find regressions, and some of the device driver patches are not currently
> in a state where I could submit them. I hope that by the time of the 3.3
> merge window, I have enough patches upstream that you no longer need to
> pull in an extra tree.
> 
Sounds like a plan and having these scripts working on mainline kernel
would be really great to test new set dependencies.

Thanks a lot for the patches.

Segards
Santosh
