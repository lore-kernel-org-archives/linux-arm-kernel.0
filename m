From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 19 Nov 2013 10:20:47 -0500
Subject: [RFC PATCH V2 2/2] kbuild: dtbs_install: new make target
In-Reply-To: <20131119150212.GM16735@n2100.arm.linux.org.uk>
References: <528A65DF.8060000@wwwdotorg.org>
 <20131118191955.GG10335@titan.lakedaemon.net>
 <528A6944.3070303@wwwdotorg.org>
 <20131118192852.GI10335@titan.lakedaemon.net>
 <528A6CA3.9030904@wwwdotorg.org>
 <20131118195243.GJ10335@titan.lakedaemon.net>
 <528A98C8.9040803@wwwdotorg.org>
 <20131119122801.GL16735@n2100.arm.linux.org.uk>
 <20131119142336.GA28859@titan.lakedaemon.net>
 <20131119150212.GM16735@n2100.arm.linux.org.uk>
Message-ID: <20131119152047.GB28859@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Tue, Nov 19, 2013 at 03:02:12PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 19, 2013 at 09:23:36AM -0500, Jason Cooper wrote:
> > All I'm suggesting doing is extending the same standard we have for
> > compatible strings at the node level to the board level.  If we don't
> > change the filename,

To be clear, by this I meant dtbs_install changing
armada-370-mirabox.dtb to globalscale,mirabox.dtb.

> > then we *have* to extend the consistent naming to the dts files as
> > well.
> 
> That, in itself, is not a bad thing to do, and totally solves the problem.

By "That" are you referring to extending the standard for compatible
strings to the board level, or forcing consistent naming on the dts
files?

thx,

Jason.
