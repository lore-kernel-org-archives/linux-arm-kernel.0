From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Jan 2016 08:24:53 -0800
Subject: [PATCH] ARM: dts: n900: Include adp1653 device
In-Reply-To: <20160127111828.GK5783@n2100.arm.linux.org.uk>
References: <1451086812-3729-1-git-send-email-pali.rohar@gmail.com>
 <20160121091241.GS7192@pali>
 <20160121092909.GH5783@n2100.arm.linux.org.uk>
 <20160121101828.GA7411@amd> <20160121163857.GH19432@atomide.com>
 <20160121165408.GJ5783@n2100.arm.linux.org.uk>
 <20160127100237.GH25796@pali>
 <20160127111828.GK5783@n2100.arm.linux.org.uk>
Message-ID: <20160127162452.GJ19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [160127 03:19]:
> On Wed, Jan 27, 2016 at 11:02:37AM +0100, Pali Roh?r wrote:
> > In my opinion this patch is not support for new hardware. It just add
> > missing DT definition for one specific board for HW which was added to
> > linux kernel in v4.2-rc1 version. For me it looks like that needed DT
> > definition was forgotten...
> 
> Opinions differ, but ultimately it's up to whoever is responsible for
> accepting the patch, and in the case of ARM SoC based patches, the
> arm-soc maintainers.

Yeah. Sorry for long delay as discussed. I'm applying the $subject
patch finally into omap-for-v4.6/dt today.

We still have at least two fixes left to go that both affect also
n900. But at least I can now sanely test adding new stuff with a WIP
fix for the PM runtime regression.

> The arm-soc maintainers close their trees for development changes a
> few weeks before hand (a patch of mine which was acked etc by 7th
> December never made the 4.5 merge window either, and the alleged
> reason I've been told is because arm-soc was already closed by then).

Heh I too have some pending clock framework patches from December
that I did not repost yet as the maintainers notified that they
rather not take new stuff any longer for v4.5 before the holidays.

Regards,

Tony
