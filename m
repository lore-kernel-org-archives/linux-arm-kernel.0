From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 17 Jul 2013 11:44:17 +0100
Subject: [RFC PATCH v5 0/1] drivers: mfd: Versatile Express SPC support
In-Reply-To: <1374052705.3146.86.camel@hornet>
References: <1373990743-23106-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1374052705.3146.86.camel@hornet>
Message-ID: <20130717104416.GA1896@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 10:18:25AM +0100, Pawel Moll wrote:
> On Tue, 2013-07-16 at 17:05 +0100, Lorenzo Pieralisi wrote:
> > /drivers/mfd is probably not the right place for this code as it stands (but
> > probably will be when the entire driver, with DVFS and config interface, is
> > complete).
> 
> Not that it really matters now, but my vexpress-sysreg rework will -
> most likely - leave only skeleton in the MFD (registering mfd_cells) and
> other stuff is going to be spread all around. Then I'm planning to move
> the remaining of the vexpress-specific initialization to
> drivers/platform/arm/vexpress.c, so maybe sticking vexpress-spc.c to
> this (non-existing yet) directory would be the right thing to do?

Done. I do not think there is a point in splitting the patch to create
the dir and make infrastructure, so I squashed everything in the
original patch. I have not added any maintainer for that dir/file, I
guess it can wait till you finish the rework so that you can add
yourself there.

If that's all I need to change I do not even think that reposting is
necessary.

It does matter though, since it implies changes on who is in charge of
ack/nack'ing this code, if it is no more an mfd matter.

I will wait to check all interested/concerned parties opinions, that are
always welcome.

> Other than that:
> 
> Acked-by: Pawel Moll <pawel.moll@arm.com>

Thank you !!!
Lorenzo
