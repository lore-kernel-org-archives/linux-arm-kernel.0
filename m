From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 9 Mar 2011 15:02:27 +0100
Subject: [PATCH 2 00/18] I2C: OMAP: Fixes and removal of cpu_... from
	driver
In-Reply-To: <20110308233820.GJ26463@atomide.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
	<4D76A164.2060801@ti.com> <20110308233820.GJ26463@atomide.com>
Message-ID: <4D778873.4070308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 3/9/2011 12:38 AM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [110308 13:34]:
>> Hi Andy,
>>
>> Thanks for that really fast update. That looks pretty good at first
>> glance. I still have to review in details.
>
> Yes nice job!
>
>> And we need to find some volunteers for OMAP1&  2 testing.
>
> I gave it a quick try on osk5912, seems to work just fine.
> Will apply these for testing purposes to linux-omap tree while
> waiting for the minor fixes.
>
> Looks like Benoit should take the arch/arm/*omap*/*hwmod*
> patches, the rest should go throug Ben. So for all of them:

Paul and I already acked the hwmod data, but the whole series should 
maybe go through Ben, because the hwmod files will need some defines 
added in the i2c header file. So we cannot separate the hwmod* patches 
from the driver files patches.

I just have one minor comment to keep the OMAP4 data in sync with the 
autogen, but if Andy does not have any important update to do on that 
series, I can potentially fix that later.

Regards
Benoit
