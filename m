From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 17 Jul 2013 10:18:25 +0100
Subject: [RFC PATCH v5 0/1] drivers: mfd: Versatile Express SPC support
In-Reply-To: <1373990743-23106-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1373990743-23106-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1374052705.3146.86.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-07-16 at 17:05 +0100, Lorenzo Pieralisi wrote:
> /drivers/mfd is probably not the right place for this code as it stands (but
> probably will be when the entire driver, with DVFS and config interface, is
> complete).

Not that it really matters now, but my vexpress-sysreg rework will -
most likely - leave only skeleton in the MFD (registering mfd_cells) and
other stuff is going to be spread all around. Then I'm planning to move
the remaining of the vexpress-specific initialization to
drivers/platform/arm/vexpress.c, so maybe sticking vexpress-spc.c to
this (non-existing yet) directory would be the right thing to do?

Other than that:

Acked-by: Pawel Moll <pawel.moll@arm.com>

Thanks!

Pawe?
