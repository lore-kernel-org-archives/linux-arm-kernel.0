From: olof@lixom.net (Olof Johansson)
Date: Sun, 23 Feb 2014 05:57:25 -0800
Subject: [PATCH v2] MAINTAINERS: add additional ARM BCM281xx/BCM11xxx
 maintainer
In-Reply-To: <CAEPRUYqxHwSYVPV-1Td3dHsBydDybJh5YLY0+GoN+vnakGaTtw@mail.gmail.com>
References: <1392390903-19826-1-git-send-email-mporter@linaro.org>
 <CAEPRUYqxHwSYVPV-1Td3dHsBydDybJh5YLY0+GoN+vnakGaTtw@mail.gmail.com>
Message-ID: <20140223135725.GA10833@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 08:37:41AM -0800, Christian Daudt wrote:
> On Fri, Feb 14, 2014 at 7:15 AM, Matt Porter <mporter@linaro.org> wrote:
> > Add myself as an additional maintainer for the Broadcom mobile
> > SoCs.
> >
> > Signed-off-by: Matt Porter <mporter@linaro.org>
> > ---
> > Since v1: put back my missing SOB
> >
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b2cf5cf..9d6fbfd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1860,6 +1860,7 @@ F:        drivers/net/ethernet/broadcom/bnx2x/
> >
> >  BROADCOM BCM281XX/BCM11XXX ARM ARCHITECTURE
> >  M:     Christian Daudt <bcm@fixthebug.org>
> > +M:     Matt Porter <mporter@linaro.org>
> >  L:     bcm-kernel-feedback-list at broadcom.com
> >  T:     git git://git.github.com/broadcom/bcm11351
> >  S:     Maintained
> > --
> > 1.8.4
> >
> Acked-by: Christian Daudt <bcm@fixthebug.org>

Applied to fixes, thanks.


-Olof
