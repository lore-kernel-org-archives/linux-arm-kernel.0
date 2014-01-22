From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jan 2014 23:29:22 +0000
Subject: [PATCH v3 19/24] drm/i2c: tda998x: use global constants
In-Reply-To: <20140119195845.13b8a0e9@armhf>
References: <cover.1390153344.git.moinejf@free.fr>
 <20140119195845.13b8a0e9@armhf>
Message-ID: <20140122232922.GP15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 07:58:45PM +0100, Jean-Francois Moine wrote:
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Might be worth also saying "and tidy up AIP_CLKSEL" since arguably they
were already using global constants.  In any case, no one likes single
line patch descriptions.  Always try to write something more about the
patch.

I've verified this via inspection, and tested it.

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
