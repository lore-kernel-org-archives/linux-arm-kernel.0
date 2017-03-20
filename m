From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Mar 2017 10:41:46 +0000
Subject: [PATCH 4/4] media: imx-media-capture: add frame sizes/interval
 enumeration
In-Reply-To: <20170320092330.GA28094@frolo.macqel>
References: <20170319103801.GQ21222@n2100.armlinux.org.uk>
 <E1cpYOa-0006Eu-CL@rmk-PC.armlinux.org.uk>
 <20170320085512.GA20923@frolo.macqel>
 <20170320090524.GC21222@n2100.armlinux.org.uk>
 <20170320092330.GA28094@frolo.macqel>
Message-ID: <20170320104146.GF21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 10:23:30AM +0100, Philippe De Muyter wrote:
> So existing gstreamer applications using /dev/video* to control framerate,
> and even gain and exposure won't work anymore :( ?
> 
> I had hoped to keep compatibility, with added robustness and functionality.
> 
> I seems like I'll stay with my NXP/Freescale old and imperfect kernel.

Thank you for saying this, this supports my views which I've already
stated about what influences which kernel people will use.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
