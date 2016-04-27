From: Linux.HWI@garmin.com (J.D. Schroeder)
Date: Wed, 27 Apr 2016 15:13:30 -0500
Subject: [PATCH 2/3] ARM: DRA7x: dts: Fix the 32kHz clock calculation
In-Reply-To: <5721175B.8030904@ti.com>
References: <1461693269-19436-1-git-send-email-Linux.HWI@garmin.com>
 <1461693269-19436-3-git-send-email-Linux.HWI@garmin.com>
 <5720A51E.2000900@ti.com> <5720C77A.3020708@garmin.com>
 <5721175B.8030904@ti.com>
Message-ID: <57211D6A.407@garmin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2016 02:47 PM, Tero Kristo wrote:
> The patch is merged already in 4.6-rc3.
> 
> Which repo / version are you using as baseline?

I'm using git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git. I
can see eea08802f586acd6aef377d1b4a541821013cc0b as of now. However, I don't
think it was included in -rc3 or even -rc5 which is what I was basing my
changes on. It looks like it got merged in late last night in Linus tree. No
big deal. The change is nearly identical to my solution so no need to pursue mine.

Please disregard this patch.

Thanks,
JD
