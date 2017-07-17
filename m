From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Jul 2017 10:47:40 +0200
Subject: [PATCH 04/18] drm/sun4i: Remove useless atomic_check
In-Reply-To: <CAGb2v67=x+6tdKsKEkY2VS75H561zUfh55h2sNUcrCERr+z72A@mail.gmail.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
 <effdc5f1e0fe485b141c057bb66f9dadf7433a88.1499955058.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67=x+6tdKsKEkY2VS75H561zUfh55h2sNUcrCERr+z72A@mail.gmail.com>
Message-ID: <20170717084740.5bwzjevaxkedz7zp@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 11:15:18AM +0800, Chen-Yu Tsai wrote:
> On Thu, Jul 13, 2017 at 10:12 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The atomic_check callback is optional, and we don't implement anything in
> > some parts of our drivers. Let's remove it.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170717/9259ac6d/attachment.sig>
