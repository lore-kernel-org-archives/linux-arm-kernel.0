From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 22 Sep 2018 21:32:13 +0800
Subject: [PATCH 09/27] dt-bindings: display: sun4i-drm: Add H6 display
 engine compatibles
In-Reply-To: <5b9f3f4d.1c69fb81.c776b.ee42@mx.google.com>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-10-jernej.skrabec@siol.net>
 <5b9f3f4d.1c69fb81.c776b.ee42@mx.google.com>
Message-ID: <CAGb2v67yHpV042LW=iwBBNV7krauwCGX8CFh23nTNFsHkHXQqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 1:44 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sun,  2 Sep 2018 09:26:25 +0200, Jernej Skrabec wrote:
> > This commit adds compatibles used in H6 display pipeline, namely for
> > display engine, mixer and TV TCON.
> >
> > H6 display engine is somewhat similar to R40, just less TCONs and
> > mixer support more features.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> >  .../devicetree/bindings/display/sunxi/sun4i-drm.txt          | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
