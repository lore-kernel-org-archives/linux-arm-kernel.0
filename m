From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 24 Aug 2014 14:08:19 +0200
Subject: [PATCH v3 0/6] Migrate PXA27x platforms to clock framework
In-Reply-To: <87d2bq43pc.fsf@free.fr>
References: <1406753464-15000-1-git-send-email-robert.jarzmik@free.fr>
 <1465795.XsPpj3dZHX@wuerfel> <87d2bq43pc.fsf@free.fr>
Message-ID: <201408241408.19861.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 24 August 2014, Robert Jarzmik wrote:
> > By default, I'd expect Haojian to pick up the patches and send
> > us a pull request. He sent an Ack, but also didn't make it clear
> > that we should pick them up.
> I was thinking that they would go through the clk maintainers, hence Haojian's
> ack. If they should go through arm-soc, they would need Mike's ack.

Right, makes sense. We have in the past done it either way for other
platforms. When merging the patches through the clk subsystem, it still
makes sense to let us know of those plans and ask for an Ack from
the arm-soc maintainers, to be sure we can plan ahead in case there
are other (conflicting) patch sets that are sent through arm-soc.

	Arnd
