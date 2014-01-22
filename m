From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jan 2014 21:21:07 +0000
Subject: [PATCH v3 02/24] drm/i2c: tda998x: check more I/O errors
In-Reply-To: <20140119195838.348f8d6d@armhf>
References: <cover.1390153344.git.moinejf@free.fr>
 <20140119195838.348f8d6d@armhf>
Message-ID: <20140122212107.GF15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 07:58:38PM +0100, Jean-Francois Moine wrote:
> This patch adds more error checking inn I2C I/O functions.
> In case of I/O error, this permits to avoid writing in bad controller
> pages, a bad chipset detection or looping when getting the EDID.
> 
> Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
