From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Oct 2015 19:08:21 +0200
Subject: [PATCH v3 1/5] ARM: sunxi: Add R8 support
In-Reply-To: <CAGb2v65b-viLFXdFrx_A864Ekc90CJtWr0JYKAAs=yrZ+K8CUw@mail.gmail.com>
References: <1444380177-15302-1-git-send-email-maxime.ripard@free-electrons.com>
 <1444380177-15302-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v65b-viLFXdFrx_A864Ekc90CJtWr0JYKAAs=yrZ+K8CUw@mail.gmail.com>
Message-ID: <20151011170821.GS2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 10:20:29PM +0800, Chen-Yu Tsai wrote:
> On Fri, Oct 9, 2015 at 4:42 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The R8 is a new Allwinner SoC based on the A13. While both are very
> > similar, there's still a few differences. Introduce a new compatible to
> > deal with them.
> >
> > In order to have a consistent naming, instead of mentionning the allwinner
>                                                    ^               ^
> nit:                                               mentioning      Allwinner
> 
> Fix when you apply?
> 
> > A series as the machine name, switch to sun4i/sun5i like what is done for
> > the other families.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Fixed the typos and applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151011/984c94e4/attachment.sig>
