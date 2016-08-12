From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Aug 2016 15:26:46 +0100
Subject: [PATCH RFC 4/5] drm/bridge: add dw-hdmi cec driver using Hans
 Verkil's CEC code
In-Reply-To: <d417880e-8628-5d90-9487-e88d283f309c@cisco.com>
References: <20160812141421.GB1041@n2100.armlinux.org.uk>
 <E1bYDEs-0004rs-FP@rmk-PC.armlinux.org.uk>
 <d417880e-8628-5d90-9487-e88d283f309c@cisco.com>
Message-ID: <20160812142646.GD1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2016 at 04:25:02PM +0200, Hans Verkuil wrote:
> On 08/12/2016 04:15 PM, Russell King wrote:
> >Add a CEC driver for the dw-hdmi hardware using Hans Verkil's CEC
> 
> That's Verkuil :-)

Oops, sorry about that.

> BTW, since cec is part of the media subsystem please include linux-media
> for the next round.

I can't guarantee that, I'm quite forgetful.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
