From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Jan 2014 17:07:45 +0000
Subject: [PATCH v2 4/28] drm/i2c: tda998x: change probe message origin
In-Reply-To: <20140109115827.18d0df97@armhf>
References: <20140109115827.18d0df97@armhf>
Message-ID: <20140111170745.GQ15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 11:58:27AM +0100, Jean-Francois Moine wrote:
> This patch gives a more precise information about the device getting the
> TDA chip version.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

Please consider giving an example in the description of the old and new
in the above description.  In other words:

	armada-drm armada-510-drm: found TDA19988

becomes

	tda998x 0-0070: found TDA19988

Thanks.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
