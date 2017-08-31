From: horms@verge.net.au (Simon Horman)
Date: Thu, 31 Aug 2017 10:36:46 +0200
Subject: [PATCH] arm64: dts: r8a7795: Drop bogus HDMI node names suffixes
In-Reply-To: <3276171.anaVMsVBRO@avalon>
References: <1504087397-6211-1-git-send-email-geert+renesas@glider.be>
 <3276171.anaVMsVBRO@avalon>
Message-ID: <20170831083645.GE29946@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 01:10:58PM +0300, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the patch.
> 
> On Wednesday, 30 August 2017 13:03:17 EEST Geert Uytterhoeven wrote:
> > Node names should not use numerical suffixes if the nodes can be
> > distinguished by unit-address.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, applied.
