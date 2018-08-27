From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 27 Aug 2018 14:02:00 +0200
Subject: [RESEND 0/5] drm/mxsfb: Fix runtime PM for unpowering lcdif block
In-Reply-To: <cover.1535367027.git.leonard.crestez@nxp.com>
References: <cover.1535367027.git.leonard.crestez@nxp.com>
Message-ID: <1535371320.5076.4.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leonard,

On Mon, 2018-08-27 at 14:10 +0300, Leonard Crestez wrote:
> Adding lcdif nodes to a power domain currently doesn't work, it results
> in black/corrupted screens or hangs. While the driver does enable
> runtime pm it does not deal correctly with the block being unpowered.
> 
> All patches in this series have review tags from a few weeks ago. I'm
> resending this today because 4.19 rc1 was released. I'm not sure if this
> matters for DRM but in some areas unrelated series get lost during the
> merge window.
> 
> Marek/Phillip: Is one of you going to pick up these patches?

I assumed Marek would pick them up.

Marek, should I push these patches to drm-misc-fixes?

regards
Philipp
