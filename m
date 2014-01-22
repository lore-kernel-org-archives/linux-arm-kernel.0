From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jan 2014 21:28:20 +0000
Subject: [PATCH v3 07/24] drm/i2c: tda998x: set the video mode from the
 adjusted value
In-Reply-To: <20140119195840.1ecab03b@armhf>
References: <cover.1390153344.git.moinejf@free.fr>
 <20140119195840.1ecab03b@armhf>
Message-ID: <20140122212820.GH15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 07:58:40PM +0100, Jean-Francois Moine wrote:
> This patch uses always the adjusted video mode instead of a mix of
> original and adjusted mode.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Nothing obviously wrong and appears to work, thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
