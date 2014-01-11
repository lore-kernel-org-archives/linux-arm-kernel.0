From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Jan 2014 17:13:57 +0000
Subject: [PATCH v2 8/28] drm/i2c: tda998x: use HDMI constants
In-Reply-To: <20140109115923.666c063a@armhf>
References: <20140109115923.666c063a@armhf>
Message-ID: <20140111171357.GU15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 11:59:23AM +0100, Jean-Francois Moine wrote:
> This patch replaces hard coded values by hdmi constants.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

It should be noted that there's a bug fix in this patch as well - it
fixes an uninitialised byte in the AIF packet, and _that_ change should
be separated so that it can be backported to stable trees.

Thanks.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
