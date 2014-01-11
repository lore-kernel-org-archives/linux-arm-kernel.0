From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Jan 2014 18:15:56 +0000
Subject: [PATCH v2 14/28] drm/i2c: tda998x: get a better status of the
 connexion
In-Reply-To: <20140109120428.1ea7ec3a@armhf>
References: <20140109120428.1ea7ec3a@armhf>
Message-ID: <20140111181556.GC15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 12:04:28PM +0100, Jean-Francois Moine wrote:
> This patch refines the connexion status testing both bits RXSENS and
> HPD of the CEC register giving the connexion level.

In English, it's spelt "connection" - there is no x, despite it sounding
like there is.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
