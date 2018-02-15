From: horms@verge.net.au (Simon Horman)
Date: Thu, 15 Feb 2018 17:50:01 +0100
Subject: [PATCH 7/8] arm64: dts: renesas: r8a77995-draak: Add HDMI Out
 through ADV7511
In-Reply-To: <2517305.jdPBFiRQEk@avalon>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
 <1518683903-10681-8-git-send-email-kbingham@kernel.org>
 <2517305.jdPBFiRQEk@avalon>
Message-ID: <20180215165000.j6szepze6tyfww7n@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 04:16:00PM +0200, Laurent Pinchart wrote:
> Hi Kieran,
> 
> Thank you for the patch.
> 
> On Thursday, 15 February 2018 10:38:22 EET Kieran Bingham wrote:
> > From: Kieran Bingham <kieran.bingham@ideasonboard.com>
> > 
> > Provide a device node for the ADV7511 as found on the Draak D3 platform.
> > 
> > The ADV7511 is connected to the DU through a parallel mux chip, and is
> > configurable in hardware whether it is connected to LVDS0 or LVDS1.
> > 
> > Connect through to LVDS0 as a default implementation.
> 
> You need to model the LVDS decoder in DT too. I know that no driver and no DT 
> bindings are available at the moment, and I'm aware that this patch enables 
> the HDMI output on the Draak board, but I don't think it's upstreamable as-is.

Thanks, I've marked this as "Changes Requested".
