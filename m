From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Date: Tue, 4 Nov 2014 16:03:15 -0500
Subject: [PATCH 11/13] arm: dts: dra7: add DMA properties for UART
In-Reply-To: <20141104183315.GD24112@csclub.uwaterloo.ca>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
 <1412014009-13315-12-git-send-email-bigeasy@linutronix.de>
 <20141104170233.GB24112@csclub.uwaterloo.ca>
 <5459079D.7080703@linutronix.de>
 <20141104172117.GC24112@csclub.uwaterloo.ca>
 <20141104183315.GD24112@csclub.uwaterloo.ca>
Message-ID: <20141104210315.GF24112@csclub.uwaterloo.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 01:33:15PM -0500, Lennart Sorensen wrote:
> Well it doesn't work, because I don't have the dma croassbar patches
> from ti-linux-3.14.y which are required to use the full range of dma
> channels on the dra7.
> 
> I will see how well it works without dma at least.

So it seems to be working on our board so far.  Will stress test it
some more.  No DMA of course for now, but oh well.

-- 
Len Sorensen
