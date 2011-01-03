From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Jan 2011 11:01:54 +0000
Subject: [PATCH 0/7] PL011 DMA support
In-Reply-To: <20110103100753.GB26785@n2100.arm.linux.org.uk>
References: <20110103100753.GB26785@n2100.arm.linux.org.uk>
Message-ID: <20110103110154.GJ26785@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 03, 2011 at 10:07:54AM +0000, Russell King - ARM Linux wrote:
> This is another posting of the PL011 DMA patch set, with a new patch
> to include the PL011 revision in the boot time messages, and fixups
> to the DMA patch as a result of discussions with Dan.
> 
> Acks for patches 1 and 6 would be appreciated.

I'd like to have an ack from Linus for patches 1 and 6, and an ack from
Dan for just patch 6.  Once I have those acks, I think PL011 TX DMA
support is good to go for this merge window.
