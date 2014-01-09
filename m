From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Jan 2014 15:33:28 +0000
Subject: [PATCH RFC 27/46] imx-drm: convert to componentised device support
In-Reply-To: <20140109152536.GG21717@S2101-09.ap.freescale.net>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1VypoB-0007FJ-PA@rmk-PC.arm.linux.org.uk>
 <20140107085930.GD12346@S2101-09.ap.freescale.net>
 <20140108213258.GS27432@n2100.arm.linux.org.uk>
 <20140109152536.GG21717@S2101-09.ap.freescale.net>
Message-ID: <20140109153327.GE27432@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 11:25:38PM +0800, Shawn Guo wrote:
> Yea, adding all four into imx-drm crtcs works for imx6q, but it doesn't
> for imx6dl, because &ipu2 is unavailable for imx6dl at all.
> 
> Here is how I get around it.

Thanks, I've rolled your change into this commit now.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
