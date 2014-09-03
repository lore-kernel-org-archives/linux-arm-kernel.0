From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Sep 2014 21:33:31 +0200
Subject: [PATCH v3 0/6] Migrate PXA27x platforms to clock framework
In-Reply-To: <20140903184956.11368.47800@quantum>
References: <1406753464-15000-1-git-send-email-robert.jarzmik@free.fr>
 <201408241408.19861.arnd@arndb.de> <20140903184956.11368.47800@quantum>
Message-ID: <3966110.RPrxdc8FBm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 11:49:56 Mike Turquette wrote:
> > Right, makes sense. We have in the past done it either way for other
> > platforms. When merging the patches through the clk subsystem, it still
> > makes sense to let us know of those plans and ask for an Ack from
> > the arm-soc maintainers, to be sure we can plan ahead in case there
> > are other (conflicting) patch sets that are sent through arm-soc.
> 
> Do I have your Ack for the arch/arm patches?
> 
> [0] https://lkml.kernel.org/r/<1409758148-20104-1-git-send-email-tomeu.vizoso@collabora.com>

I have no objection to the change, but we might need to be careful in
case we get a lot of conflicts.

How about making it a shared branch that you plan to send upstream
but that we can also include in arm-soc to avoid conflicts if necessary?

	Arnd
