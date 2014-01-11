From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Jan 2014 18:51:14 +0000
Subject: [PATCH v2 23/28] drm/i2c: tda998x: add the active aspect in
 HDMI AVI frame
In-Reply-To: <20140109120639.5f76c620@armhf>
References: <20140109120639.5f76c620@armhf>
Message-ID: <20140111185114.GK15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 12:06:39PM +0100, Jean-Francois Moine wrote:
> This patch adds the active aspect as 'picture' in the HDMI AVI frame
> and also some comments about this frame.

Yes, this should've been set.  It's probably a stable tree candidate,
but first it needs testing.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
