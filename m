From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Oct 2017 16:37:11 +0200
Subject: [PATCH 04/23] drm/sun4i: tcon: Make tcon_get_clk_delay mode
 argument const
In-Reply-To: <CAGb2v65BNixB8evAqk-7uRKL=OuRW2aa+4gNedz5CdXEBoFACw@mail.gmail.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
 <e6f92f126640aa6de639386f9b4677db3d8bb37b.1508231063.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65BNixB8evAqk-7uRKL=OuRW2aa+4gNedz5CdXEBoFACw@mail.gmail.com>
Message-ID: <20171017143711.intnpnenslwqyktr@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 05:22:03PM +0800, Chen-Yu Tsai wrote:
> On Tue, Oct 17, 2017 at 5:06 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The drm_display_mode pointer can be mark const, so let's do it.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171017/73e38f65/attachment.sig>
