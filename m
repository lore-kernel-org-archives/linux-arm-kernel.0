From: bgamari.foss@gmail.com (Ben Gamari)
Date: Thu, 20 Jan 2011 16:44:42 -0500
Subject: [PATCH] omap2-beagle: Depend upon CONFIG_GPIO_TWL4030
In-Reply-To: <20110120040825.GB2389@legolas.emea.dhcp.ti.com>
References: <1295299548-22839-1-git-send-email-bgamari.foss@gmail.com>
	<20110118031038.GA2436@legolas.emea.dhcp.ti.com>
	<87d3nus4jr.fsf@gmail.com>
	<20110119034528.GA2406@legolas.emea.dhcp.ti.com>
	<874o947j9e.fsf@gmail.com>
	<20110120040825.GB2389@legolas.emea.dhcp.ti.com>
Message-ID: <8739ondzcl.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--text follows this line--
On Thu, 20 Jan 2011 06:08:25 +0200, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Jan 19, 2011 at 03:04:13PM -0500, Ben Gamari wrote:
> > I understand. That being said, Linus has made it well known that
> > defconfigs will not be an option going forward. Have we found another
> 
> I never mentioned defconfigs here.
> 
Certainly, I was trying to point out that there is no good way to
package a configuration for a given board, which definitely increases
the learning curve for a board integrator.

> > means of selecting the basic drivers necessary to get a fully functional
> > board? Perhaps a CONFIG_MACH_OMAP3_BEAGLE_CORE option selecting the
> > necessary driver for a fully functional board would be a solution. I
> 
> I'll leave this for Tony to decide, but I don't like your proposal.
> 
Fair enough.

> So you're saying that when you're building a kernel for you
> laptop/desktop you don't have to get a menuconfig and choose the drivers
> you want to compile ? I dare to doubt that.
> 
On the whole x86 hardware is far more uniform than ARM hardware. There
is a good reason why there used to be so many defconfigs for ARM in the tree.

Cheers,

- Ben
