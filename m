From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Jan 2014 17:08:22 +0000
Subject: [PATCH v2 5/28] drm/i2c: tda998x: don't freeze the system at
 audio startup time
In-Reply-To: <20140109115840.67c9e2d4@armhf>
References: <20140109115840.67c9e2d4@armhf>
Message-ID: <20140111170822.GR15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 11:58:40AM +0100, Jean-Francois Moine wrote:
> This patch prevents the system to be freezed at audio startup time,
> replacing mdelay by msleep.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
