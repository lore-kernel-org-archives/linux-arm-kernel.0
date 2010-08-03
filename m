From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Aug 2010 08:25:26 +0100
Subject: [PATCH] omap: Fix DEBUG_LL uart to access phys addr when MMU
	isn't enable
In-Reply-To: <AANLkTinNr7=8cO_E4zaXF4wCcKo3=WUnAek-Dh9-kgjs@mail.gmail.com>
References: <1280807058-8394-1-git-send-email-jason77.wang@gmail.com>
	<AANLkTi=ocZPDi5eU_F8VdAzJzYRCEp+B7MZ2q3DAesa3@mail.gmail.com>
	<20100803065709.GP12293@atomide.com>
	<AANLkTinNr7=8cO_E4zaXF4wCcKo3=WUnAek-Dh9-kgjs@mail.gmail.com>
Message-ID: <20100803072526.GA11987@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 03, 2010 at 03:11:41PM +0800, Eric Miao wrote:
> We also need to take care of Jeremy's recent patchset to remove
> .io_pg_offst and .phys_io, which modifies all the addruart macros.

I don't think Jeremy's patches will be going in for this merge window as
we can't intentionally break OMAP's support because we don't understand
OMAP.  I think Jeremy's patches will have to wait for the next merge
window now.
