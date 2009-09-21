From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Sep 2009 16:11:07 +0100
Subject: [PATCH 3/3] Move MMCI header to amba include dir
In-Reply-To: <20090921150103.GB30821@n2100.arm.linux.org.uk>
References: <1252529727-7957-1-git-send-email-linus.walleij@stericsson.com>
	<20090921150103.GB30821@n2100.arm.linux.org.uk>
Message-ID: <20090921151107.GC30821@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2009 at 04:01:03PM +0100, Russell King - ARM Linux wrote:
> On Wed, Sep 09, 2009 at 10:55:27PM +0200, Linus Walleij wrote:
> > This moves the mmci platform data definition struct away from
> > arch/arm/include/asm/mach/mmc.h into the more proper place among
> > the other primecells in include/linux/amba/mmci.h and at the same
> > time renames it to "mmci.h", and also the struct in this file
> > confusingly named mmc_platform_data has been renamed
> > mmci_platform_data for clarity.
> 
> Not sure what's happened, but this patch appears to conflict with
> another, resulting in:

It's also meant that 5702/1 has been dropped in addition to 5699/1.
In future, please ensure that you run a build check on the machines
which you've modified.  Thanks.
