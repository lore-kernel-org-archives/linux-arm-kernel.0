From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 09 Feb 2012 19:50:01 +0900
Subject: [PATCH 2/9] ARM: EXYNOS: add clock part for EXYNOS5250 SoC
In-Reply-To: <CAH9JG2UjbC7-qRUirj_QqR92duyh+1FXLQufL-QW-N5te66KDA@mail.gmail.com>
References: <1328024354-4277-1-git-send-email-kgene.kim@samsung.com>
 <1328024354-4277-3-git-send-email-kgene.kim@samsung.com>
 <CAH9JG2UjbC7-qRUirj_QqR92duyh+1FXLQufL-QW-N5te66KDA@mail.gmail.com>
Message-ID: <068701cce718$92abdd70$b8039850$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On 2/1/12, Kukjin Kim <kgene.kim@samsung.com> wrote:

[snip]

> > +static int exynos5_clk_gate_block(struct clk *clk, int enable)
> exynos5_clk_block_ctrl?

OK, looks better, will change.

[snip]

> > +		.name		= "mfc",
> > +		.devname	= "s3c-mfc",
> what's this?

typo :( should be s5p-mfc.

[snip]

> > +		.name		= "hdmi",
> > +		.devname	= "exynos5-hdmi",
> I think exynos4x12 has same hdmi controller. so It will be changed as
> exynos-hdmi.

OK, let me check it but I'm not sure new exynos will have same hdmi later.

[snip]

> > +		.name		= "fimg2d",
> > +		.devname	= "s5p-fimg2d",
> s5p? exynos?

Hmm, let me think again.

[snip]

Thanks :)

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
