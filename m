From: horms@verge.net.au (Simon Horman)
Date: Tue, 22 May 2018 15:24:52 +0200
Subject: [PATCH v4 3/3] arm64: dts: renesas: draak: Describe HDMI input
In-Reply-To: <1526913942-15426-4-git-send-email-jacopo+renesas@jmondi.org>
References: <1526913942-15426-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526913942-15426-4-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <20180522132452.z7fwnwmac7ass2ix@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 04:45:42PM +0200, Jacopo Mondi wrote:
> Describe HDMI input connector and ADV7612 HDMI decoder installed on
> R-Car Gen3 Draak board.
> 
> The video signal routing to the HDMI decoder to the video input interface
> VIN4 is multiplexed with CVBS input path, and enabled/disabled through
> on-board switches SW-49, SW-50, SW-51 and SW-52.
> 
> As the default board switches configuration connects CVBS input to VIN4,
> leave the HDMI decoder unconnected in DTS.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks Jacopo,

applied.
