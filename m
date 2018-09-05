From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 5 Sep 2018 09:22:24 +0200
Subject: [PATCH v4 10/11] drm/sun4i: Add support for HDMI voltage regulator
In-Reply-To: <20180904044053.15425-11-icenowy@aosc.io>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-11-icenowy@aosc.io>
Message-ID: <20180905072224.w5u3djfxxxc2h2pc@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2018 at 12:40:52PM +0800, Icenowy Zheng wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> Some boards have HDMI VCC pin connected to voltage regulator which may
> not be turned on by default.
> 
> Add support for such boards by adding voltage regulator handling code to
> HDMI driver.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> [Icenowy: change supply name to "hvcc"]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180905/89e3ed55/attachment-0001.sig>
