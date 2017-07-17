From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Jul 2017 10:45:15 +0200
Subject: [PATCH 02/18] drm/sun4i: Add if statement instead of depends on
In-Reply-To: <CAGb2v64KXCm1SzCz1hSkk1WOA03rju5_v_Q9XdF=cSs26Wz+Tw@mail.gmail.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
 <d51d45d57d2bacaa5bafcd861aa0142fcaf0ad77.1499955058.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v64KXCm1SzCz1hSkk1WOA03rju5_v_Q9XdF=cSs26Wz+Tw@mail.gmail.com>
Message-ID: <20170717084515.itlooaskmgvcylty@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 11:09:07AM +0800, Chen-Yu Tsai wrote:
> On Thu, Jul 13, 2017 at 10:12 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The depends on relationship is obvious, and using an if statement will
> > propagate it to every option without the need for each and every one of
> > them to define it.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170717/062d0c81/attachment.sig>
