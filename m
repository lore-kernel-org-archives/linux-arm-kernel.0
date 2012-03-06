From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Mar 2012 11:07:53 +0000
Subject: Problems with "[PATCH 0/9] DMA engine cookie handling cleanups"
In-Reply-To: <CACKLOr3zFmNXYV6MW01uykp7geG=1gAkWcxYoMgLdqfzhMD9fw@mail.gmail.com>
References: <CACKLOr3zFmNXYV6MW01uykp7geG=1gAkWcxYoMgLdqfzhMD9fw@mail.gmail.com>
Message-ID: <20120306110753.GG17370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 12:03:54PM +0100, javier Martin wrote:
> Hi Russell,
> I've just seen this series in the mailing list archives:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/087917.html
> 
> As some people already stated, patch 1/9 is missing.

They weren't all sent to linux-arm-kernel - they were only sent to the
appropriate people listed in MAINTAINERS.  So if you didn't receive them,
either the patch was not touching a driver you maintain or your entries
in MAINTAINERS is incomplete.

> In my case it is even worse: I didn't received any of the patches in
> my mail-box despite being subscribed to the list.
> 
> As you'll probably have noticed, I'm doing some deep cleanup on
> 'imx-dma.c' file as you can see in the following patches:
> 
> [PATCH v2 1/2] dmaengine: Add support for MEMCPY for imx-dma.
> [PATCH v3 2/2] dmaengine: Add support for multiple descriptors for imx-dma.
> [PATCH 00/14] dmaengine: imx-dma: merge dma arch code into dmaengine.
> 
> Currently, I'm waiting for Sascha and Vinod to confirm that they are
> fine and merge them. However, your series seems to conflict with those
> patches as it modifies imx-dma.

I expect that whenever these patches get posted, there will be some kind
of conflict with some work going on somewhere else.  There's not much
which can be done to get away from that.
