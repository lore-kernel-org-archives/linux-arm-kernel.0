From: koen@dominion.thruhere.net (Koen Kooi)
Date: Fri, 14 Dec 2012 10:55:56 +0100
Subject: cpts: Fix build error caused by include of plat/clock.h
In-Reply-To: <20121214071300.GA2253@netboy.at.omicron.at>
References: <20121213213641.GF4989@atomide.com>
 <20121214071300.GA2253@netboy.at.omicron.at>
Message-ID: <45364223-10C6-430A-9085-9DE1C79030AF@dominion.thruhere.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Op 14 dec. 2012, om 08:13 heeft Richard Cochran <richardcochran@gmail.com> het volgende geschreven:

> On Thu, Dec 13, 2012 at 01:36:41PM -0800, Tony Lindgren wrote:
>> Commit 87c0e764 (cpts: introduce time stamping code and a PTP hardware clock)
>> mistakenly included plat/clock.h that should not be included by drivers
>> even if it exists.
> 
> Hasn't this already been fixed?
> 
>  https://patchwork.kernel.org/patch/1810481/
>  http://www.spinics.net/lists/linux-omap/msg83132.html

That patch didn't get applied, so it's still broken in Linus' tree :(

regards,

Koen
