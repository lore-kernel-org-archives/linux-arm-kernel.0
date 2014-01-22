From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jan 2014 23:30:13 +0000
Subject: [PATCH v3 20/24] drm/i2c: tda998x: remove the unused variable
 ca_i2s
In-Reply-To: <20140119195846.368a44e6@armhf>
References: <cover.1390153344.git.moinejf@free.fr>
 <20140119195846.368a44e6@armhf>
Message-ID: <20140122233013.GQ15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 07:58:46PM +0100, Jean-Francois Moine wrote:
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

"ca_i2s is only ever written to, but never read, so let's get rid of it."

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
