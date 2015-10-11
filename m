From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Oct 2015 17:18:44 +0100
Subject: [linux-sunxi] [PATCH] MAINTAINERS: Update Allwinner entry and
 add new maintainer
In-Reply-To: <CAGb2v67TFuFQ3ZVHRtzPQHXcM=PAo3Duvt77v9_RtjkJ9_=D1Q@mail.gmail.com>
References: <1444239580-32688-1-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v67TFuFQ3ZVHRtzPQHXcM=PAo3Duvt77v9_RtjkJ9_=D1Q@mail.gmail.com>
Message-ID: <20151011161844.GL2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 08, 2015 at 09:32:09AM +0800, Chen-Yu Tsai wrote:
> On Thu, Oct 8, 2015 at 1:39 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Add Chen-Yu Tsai as a co-maintainer to the ARM sunxi support.
> >
> > While we are doing so, also update the entry for new SoCs.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  MAINTAINERS | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 797236befd27..d6a9a016f3d4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -894,11 +894,12 @@ M:        Lennert Buytenhek <kernel@wantstofly.org>
> >  L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> >  S:     Maintained
> >
> > -ARM/Allwinner A1X SoC support
> > +ARM/Allwinner sunXi SoC support
> >  M:     Maxime Ripard <maxime.ripard@free-electrons.com>
> > +M:     Chen-Yu Tsai <wens@csie.org>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> 
> >  L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> >  S:     Maintained
> > -N:     sun[x4567]i
> > +N:     sun[x456789]i
> 
> I thought we updated this already, in d30dbc6de5732 ("ARM: sunxi:
>  Add sun[89]i to MAINTAINERS entry"). It's in your
>  sunxi/core-for-4.4 branch.

Ah right. I wanted this to be applied directly for 4.3, so I based it
on 4.3-rc4, that didn't have that commit.

In order to avoid the potential conflicts, I think the ARM-SoC
maintainers should simply merge this one, and I'll drop my branch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151011/c1e51c57/attachment.sig>
