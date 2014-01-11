From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Jan 2014 18:18:32 +0000
Subject: [PATCH v2 15/28] drm/i2c: tda998x: use the tda998x video
 format when cea mode
In-Reply-To: <20140109120448.24d89eba@armhf>
References: <20140109120448.24d89eba@armhf>
Message-ID: <20140111181832.GD15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 12:04:48PM +0100, Jean-Francois Moine wrote:
> This patch uses the tda998x video format tied to the CEA mode.
> This reduces the number of i2c exchanges.

It is my understanding that one of the major design goals of this driver
is to avoid the use of such a table, and therefore this change is
undesirable by the original driver authors.  This is more a comment for
Rob to pick up on.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
