From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Jun 2012 09:45:47 +0100
Subject: [PATCH v2 2/4] ARM: add flush_mem api for ARMv6
In-Reply-To: <CADysL2acF3ttJ-TR2as+GT66MfJiK4YyWYaAiP5j8yQ+YLBGYQ@mail.gmail.com>
References: <CADysL2acF3ttJ-TR2as+GT66MfJiK4YyWYaAiP5j8yQ+YLBGYQ@mail.gmail.com>
Message-ID: <20120620084547.GB13009@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 04:51:16PM +0530, Gupta, Ramesh wrote:
> >From 630a3a8f341eb7f58f9a63bf786d732b5bdfd01e Mon Sep 17 00:00:00 2001
> From: Ramesh Gupta G <grgupta@ti.com>
> Date: Fri, 15 Jun 2012 16:39:21 +0530
> Subject: [PATCH v2 2/4] ARM: add flush_mem api for ARMv6
> 
> Added flush_mem cache maintenance api for ARMv6.
> The implementation is based on dma_flush_range.

And what about all the other users of the define_cache_functions macro?

This series is incomplete, and therefore entirely unsuitable for
upstreaming.
