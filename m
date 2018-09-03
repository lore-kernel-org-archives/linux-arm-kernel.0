From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 3 Sep 2018 13:51:08 +0000
Subject: [RESEND 0/5] drm/mxsfb: Fix runtime PM for unpowering lcdif block
In-Reply-To: <1535371320.5076.4.camel@pengutronix.de>
References: <cover.1535367027.git.leonard.crestez@nxp.com>
 <1535371320.5076.4.camel@pengutronix.de>
Message-ID: <e07f5b7148520fd22be39e48a26f4d45f1fb79f1.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-08-27 at 14:02 +0200, Philipp Zabel wrote:
> Hi Leonard,
> 
> On Mon, 2018-08-27 at 14:10 +0300, Leonard Crestez wrote:
> > Adding lcdif nodes to a power domain currently doesn't work, it results
> > in black/corrupted screens or hangs. While the driver does enable
> > runtime pm it does not deal correctly with the block being unpowered.
> > 
> > All patches in this series have review tags from a few weeks ago. I'm
> > resending this today because 4.19 rc1 was released. I'm not sure if this
> > matters for DRM but in some areas unrelated series get lost during the
> > merge window.
> > 
> > Marek/Phillip: Is one of you going to pick up these patches?
> 
> I assumed Marek would pick them up.
> 
> Marek, should I push these patches to drm-misc-fixes?

It's been another week, can't we assume nobody minds if thse patches
are pushed?

--
Regards,
Leonard
