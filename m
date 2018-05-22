From: horms@verge.net.au (Simon Horman)
Date: Tue, 22 May 2018 15:24:13 +0200
Subject: [PATCH v4 2/3] arm64: dts: renesas: draak: Describe CVBS input
In-Reply-To: <1958464.yiJe0NDHa3@avalon>
References: <1526913942-15426-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526913942-15426-3-git-send-email-jacopo+renesas@jmondi.org>
 <1958464.yiJe0NDHa3@avalon>
Message-ID: <20180522132411.7szrsk4pxvwrqrxf@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 05:50:50PM +0300, Laurent Pinchart wrote:
> Hi Jacopo,
> 
> Thank you for the patch.
> 
> On Monday, 21 May 2018 17:45:41 EEST Jacopo Mondi wrote:
> > Describe CVBS video input through analog video decoder ADV7180
> > connected to video input interface VIN4.
> > 
> > The video input signal path is shared with HDMI video input, and
> > selected by on-board switches SW-53 and SW-54 with CVBS input selected
> > by the default switches configuration.
> > 
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks Niklas, applied.
