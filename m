From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Feb 2011 23:12:41 +0000
Subject: [PATCH] arm: Use generic accessor in irq_set_flags()
In-Reply-To: <alpine.LFD.2.00.1102072349050.31804@localhost6.localdomain6>
References: <alpine.LFD.2.00.1102072349050.31804@localhost6.localdomain6>
Message-ID: <20110208231241.GA5544@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 07, 2011 at 11:56:47PM +0100, Thomas Gleixner wrote:
> The generic irq code provides an accessor function to manipulate
> status flags in the irq descriptor. Replace the open coded variant.
> 
> Neccecary to let the core code rearrange the internal representation.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
