From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 2 Sep 2010 16:48:34 +0300
Subject: [PATCH] ARM: Implement cpu_v7_reset.
In-Reply-To: <20100902121838.GB26319@n2100.arm.linux.org.uk>
References: <1283349719-21115-1-git-send-email-linus.walleij@stericsson.com>
	<20100901232307.GC25860@n2100.arm.linux.org.uk>
	<20100902083423.GI25559@gw.healthdatacare.com>
	<20100902084101.GA26319@n2100.arm.linux.org.uk>
	<20100902085341.GJ25559@gw.healthdatacare.com>
	<20100902103957.GR26319@n2100.arm.linux.org.uk>
	<20100902115206.GK25559@gw.healthdatacare.com>
	<20100902121838.GB26319@n2100.arm.linux.org.uk>
Message-ID: <20100902134834.GL25559@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 01:18:38PM +0100, Russell King - ARM Linux wrote:
> > 
> > I tested this patch without that cache invalidate instruction + dsb
> > and it still hangs. Exactly the same code works perfectly when it is run
> > via 1:1 mapping.
> 
> Where are you ultimately jumping to?

This is the normal kexec to a new kernel case so jump is to
relocate_new_kernel(), if that was what you meant.

MW
