From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Tue, 13 Nov 2018 15:46:47 +0100
Subject: [PATCH 3/5] media: sunxi: Add A10 CSI driver
In-Reply-To: <CAOMZO5DHfgV+iDo4ye7DV9CAA0QjSVXsYH1nbD2+5d9iE-uTCg@mail.gmail.com>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <c53e1cdc3b139382b00ee06bf3980d3fd1742ec0.1542097288.git-series.maxime.ripard@bootlin.com>
 <CAOMZO5CjFt1dyu8KOK+jKd88x8hwGNy9aJ-sGgooS9970TGTVQ@mail.gmail.com>
 <9a9616d2-a189-bd0e-e2e6-f84bdcb1dfd1@cisco.com>
 <CAOMZO5DHfgV+iDo4ye7DV9CAA0QjSVXsYH1nbD2+5d9iE-uTCg@mail.gmail.com>
Message-ID: <20181113154647.06900549@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 13 Nov 2018 12:13:09 -0200, Fabio Estevam wrote:

> > Actually, LICENSES/preferred/GPL-2.0 has GPL-2.0-or-later
> > as a valid license:
> >
> > Valid-License-Identifier: GPL-2.0-or-later
> >
> > Personally I very much prefer GPL-2.0-or-later since I think it is
> > much clearer.  
> 
> I saw feedback from Greg to use the SPDX style from
> Documentation/process/license-rules.rst.
> 
> Please check:
> https://lkml.org/lkml/2018/11/10/232

According to https://spdx.org/licenses/, i.e the reference SPDX site,
GPL-2.0-or-later is the right thing to use, and GPL-2.0+ is
"deprecated". But apparently Greg's feedback is "let's not used the
SDPX style, as we don't want to change this all over".

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
