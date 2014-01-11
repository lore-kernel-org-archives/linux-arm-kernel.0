From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Jan 2014 17:11:30 +0000
Subject: [PATCH v2 7/28] drm/i2c: tda998x: set the video mode from the
 adjusted value
In-Reply-To: <20140109115903.00517f15@armhf>
References: <20140109115903.00517f15@armhf>
Message-ID: <20140111171130.GT15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 11:59:03AM +0100, Jean-Francois Moine wrote:
> This patch uses always the adjusted video mode instead of a mix of
> original and adjusted mode.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

No visible side effects here, but rather than copying the "adjusted_mode"
pointer to "mode", I'd much rather see the references to "mode" become
"adjusted_mode" instead - choose a shorter name if it's too long, maybe
"adj_mode" ?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
