From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Jan 2014 17:09:44 +0000
Subject: [PATCH v2 6/28] drm/i2c: tda998x: force the page register at
 startup time
In-Reply-To: <20140109115851.63a80859@armhf>
References: <20140109115851.63a80859@armhf>
Message-ID: <20140111170944.GS15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 11:58:51AM +0100, Jean-Francois Moine wrote:
> This patch forces the page register to be set on the first I/O operation.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

No visible negative side effects, and nothing obviously wrong.

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
