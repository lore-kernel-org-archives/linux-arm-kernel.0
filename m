From: rogerq@ti.com (Roger Quadros)
Date: Thu, 11 Jul 2013 17:35:58 +0300
Subject: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
In-Reply-To: <51DEA7F1.1050902@denx.de>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com>
 <51DC09E7.1070302@denx.de> <51DC164B.5010608@ti.com>
 <51DC1B47.7070504@denx.de> <51DE87D3.5030600@ti.com>
 <51DEA7F1.1050902@denx.de>
Message-ID: <51DEC2CE.70400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2013 03:41 PM, Stefan Roese wrote:
> On 07/11/2013 12:24 PM, Roger Quadros wrote:
>> My u-boot script is below and boot log is attached.
> 
> BTW: I noticed a git ID (8e1cacd) in your kernel that I can't identify.
> Do you have any patches locally applied to the kernel.org version that
> might be helpful with this USB issue I'm seeing?

Yes I had tested it on a more recent kernel with some local patches applied
that I've recently sent for review.

But to cross check with your setup I've retested it with commit d2b4a646 
with the 2 below patches on top

https://lkml.org/lkml/2013/6/20/327
https://lkml.org/lkml/2013/6/20/339

I've tried it again with the ELDK 5.3 root but still can't get it to fail.

I think we should match our u-boot as well. Could you please let me know
your u-boot commit and uEnv.txt?

My network setup is pretty simple, beagle-xm is connected directly to my laptop's
ethernet port. No network switch in between.

When you get the problem do you cold boot the board or warm boot it?
I've been always cold booting it.

cheers,
-roger
