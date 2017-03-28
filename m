From: horms@verge.net.au (Simon Horman)
Date: Tue, 28 Mar 2017 14:30:09 +0200
Subject: [PATCH 0/4] ARM: dts: r8a7794: Correct clock of DU1
In-Reply-To: <7112167.AJcfquYAnB@avalon>
References: <1490697933-5849-1-git-send-email-geert+renesas@glider.be>
 <7112167.AJcfquYAnB@avalon>
Message-ID: <20170328123008.GB20146@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 03:08:11PM +0300, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the patches.
> 
> On Tuesday 28 Mar 2017 12:45:29 Geert Uytterhoeven wrote:
> > 	Hi Simon, Magnus,
> > 
> > In the DTS files for the R-Car E2 SoC and for development boards based
> > on this SoC, the second channel of the display unit incorrectly points
> > to the module clock for the first channel.
> > 
> > This patch series adds the missing module clock for the second channel,
> > and refers to it from the DU device node in the various DTS files.
> > 
> > Untested due to lack of hardware.
> 
> The patches look good to me.
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, I have queued these up.
