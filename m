From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Feb 2012 09:10:38 +0000
Subject: [dmaengine] [Q] jiffies value does not increase in dma_sync_wait()
In-Reply-To: <CACKLOr26BuTh8Qr8pFHoTJoyCW9ty4-Kg-YRisXmN3=spzY6_Q@mail.gmail.com>
References: <CACKLOr26BuTh8Qr8pFHoTJoyCW9ty4-Kg-YRisXmN3=spzY6_Q@mail.gmail.com>
Message-ID: <20120203091038.GI889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2012 at 09:37:48AM +0100, javier Martin wrote:
> I've introduced a couple of printk() to check why this timeout is not
> triggered and I've found that the value of jiffies does not increase
> between loop iterations (i. e. it's like time didn't advance).
> 
> Does anyobody know what reasons could make jiffies not being updated?

Are interrupts disabled?
