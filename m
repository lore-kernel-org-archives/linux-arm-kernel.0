From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Jan 2012 10:39:06 +0000
Subject: [PATCH 21/31] ARM: amba: realview: get rid of private platform
 amba_device initializer
In-Reply-To: <20120125102202.GU16726@n2100.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
 <E1RoAmo-0005Ff-DW@rmk-PC.arm.linux.org.uk>
 <20120124160044.GM19798@mudshark.cambridge.arm.com>
 <20120124162328.GA8517@n2100.arm.linux.org.uk>
 <20120124172600.GO19798@mudshark.cambridge.arm.com>
 <20120124214531.GB8517@n2100.arm.linux.org.uk>
 <20120125095800.GC21709@mudshark.cambridge.arm.com>
 <20120125102202.GU16726@n2100.arm.linux.org.uk>
Message-ID: <20120125103906.GE21709@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2012 at 10:22:02AM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 25, 2012 at 09:58:00AM +0000, Will Deacon wrote:
> > Sure. Which branch shall I take it against (before or after your amba
> > changes)?
> 
> If it's before them, we can think about putting it in as a fix during
> this -rc independently of the rest of the changes.  If it's after,
> then it'll probably add a conflict.
> 
> So, it'll be much easier to have it before, and I'll update what's
> necessary in the amba branch.

Okey doke, I've submitted it as 7300/1 against 3.3-rc1.

Will
