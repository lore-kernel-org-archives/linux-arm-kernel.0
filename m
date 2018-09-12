From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 12 Sep 2018 16:58:15 +0800
Subject: [PATCH v2 0/6] drm/sun4i: Support color dithering for LCD panels
In-Reply-To: <20180907112331.wjml25rfkyabvwwt@flea>
References: <20180907041948.19913-1-wens@csie.org>
 <20180907112331.wjml25rfkyabvwwt@flea>
Message-ID: <CAGb2v66PFTL+LJvi-d3LXNBfZCBZoRL06ORXsb4npvgEg7pZ4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2018 at 7:23 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Sep 07, 2018 at 12:19:42PM +0800, Chen-Yu Tsai wrote:
> >
> > Hi,
> >
> > This is v2 of my sun4i-drm LCD color dithering series. v1 was from back
> > in April [1]. Most of the driver code is unchanged.
> >
> > Changes since v1:
> >
> >   - Explicitly list properties from the simple-panel binding that apply
> >     to the Bananapi 7" panel
> >
> >   - Moved an incorrectly squashed change from patch 3 to patch 1, where
> >     it belongs
>
> Applied the first three patches, thanks!

Any comments on patches 4 and 5?

Thanks
ChenYu
