From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 May 2011 10:14:00 +0100
Subject: [PATCH v4 1/2] ARM: ELF: Define new core note type for VFP
	registers
In-Reply-To: <20110503093659.GA2503@arm.com>
References: <1302688597-2969-1-git-send-email-dave.martin@linaro.org>
	<1302688597-2969-2-git-send-email-dave.martin@linaro.org>
	<20110428184925.GM17290@n2100.arm.linux.org.uk>
	<20110503093659.GA2503@arm.com>
Message-ID: <20110512091400.GC1356@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2011 at 10:36:59AM +0100, Dave Martin wrote:
> On Thu, Apr 28, 2011 at 07:49:25PM +0100, Russell King - ARM Linux wrote:
> > On Wed, Apr 13, 2011 at 10:56:36AM +0100, Dave Martin wrote:
> > > The VFP registers are not currently included in coredumps,
> > > and there's no existing note type where they can sensibly be
> > > included, so this patch defines a dedicated note type for them.
> > 
> > This probably wants to be copied to LKML (added).
> 
> Good point-- thanks.

What news on this?
