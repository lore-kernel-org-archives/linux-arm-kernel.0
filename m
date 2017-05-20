From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 20 May 2017 10:38:46 +0200
Subject: [PATCH] arm64: allwinner: h5: Remove syslink to shared DTSI
In-Reply-To: <CAGb2v67yp+GL+nMy7hSmFiccqnGjmdyfZMVnPXAGRqO8j7=R7Q@mail.gmail.com>
References: <20170515085000.27965-1-maxime.ripard@free-electrons.com>
 <CAGb2v67yp+GL+nMy7hSmFiccqnGjmdyfZMVnPXAGRqO8j7=R7Q@mail.gmail.com>
Message-ID: <20170520083846.wyyu6mckrbfr6qmv@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 03:46:36PM +0800, Chen-Yu Tsai wrote:
> On Mon, May 15, 2017 at 4:50 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The arm64 H5 and arm H3 SoCs share roughly the same base, and therefore
> > share a significant part of their device tree.
> >
> > The approach we took was to add a symlink from the arm64 DTSI to the arm
> > DTSI.
> >
> > Now that the arm DT folder is exposed in the include path, we can just use
> > it and remove our symlink.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170520/ecdca40f/attachment.sig>
