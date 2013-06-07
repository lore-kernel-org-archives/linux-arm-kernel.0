From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 7 Jun 2013 10:32:41 +0200
Subject: [PATCH] arm: mvebu: ensure PCIe range is propagated in the .dts
 files
In-Reply-To: <20130606190321.GQ23859@titan.lakedaemon.net>
References: <1370510483-32419-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370510483-32419-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130606181159.GN23859@titan.lakedaemon.net>
 <20130606190321.GQ23859@titan.lakedaemon.net>
Message-ID: <20130607103241.3f82d71d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Thu, 6 Jun 2013 15:03:21 -0400, Jason Cooper wrote:

> > Can you split this in to two patches, please:
> > 
> > >  arch/arm/boot/dts/armada-xp-db.dts               | 1 +
> > 
> > one for mvebu/dt
> > 
> > >  arch/arm/boot/dts/armada-xp-gp.dts               | 5 +++--
> > >  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 5 +++--
> > 
> > and one for mvebu/fixes?
> 
> Nevermind, I've got a few minutes and would like to get it in for the
> last -next this week.

I must admit I don't quite get why the patch had to be split. The three
chunks do exactly the same thing for the three boards.

The only difference is that the part touching armada-xp-gp and
armada-xp-openblocks-ax3-4 was also adding some comments for each
range, while the one for armada-xp-db didn't had to do it because the
comments were already there.

So really, the armada-xp-db change is as much of a "fix" than the two
other changes.

To be honest, as long as they all go in 3.11, I'm fine, but I'm just
curious as to why it would have had to be split.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
