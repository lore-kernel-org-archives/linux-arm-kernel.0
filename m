From: horms@verge.net.au (Simon Horman)
Date: Tue, 1 May 2018 08:00:05 +0200
Subject: [PATCH v3] arm64: dts: renesas: v3msk: add DU/LVDS/HDMI support
In-Reply-To: <d18c4314-e6ad-1558-30fb-1a32397494b6@cogentembedded.com>
References: <23a6ac28-134b-b5dd-69a7-910774c4b8c1@cogentembedded.com>
 <d18c4314-e6ad-1558-30fb-1a32397494b6@cogentembedded.com>
Message-ID: <20180501060005.sgzgdfqt6t4smco2@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 11:45:49PM +0300, Sergei Shtylyov wrote:
> Define the V3M Starter Kit board dependent part of the DU and LVDS device
> nodes. Also add the device nodes for Thine THC63LVD1024 LVDS decoder and
> Analog Devices ADV7511W HDMI transmitter...
> 
> Based on the original (and large) patch by Vladimir Barinov.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> This patch is against the 'renesas-devel-20180423-v4.17-rc2' tag of Simon
> Horman's 'renesas.git' repo. It requires the Thine THC63LVD1024 driver in
> order to work (the same as the Eagle HDMI patch by Jacopo/Niklas).
> 
> Changes in version 3:
> - added  Thine THC63LVD1024 device node, updating the respected endpoints;
> - merged the I2C pins subnode to the main PFC device node;
> - renamed the regulators;

Thanks, applied.
