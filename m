From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Jun 2013 17:49:05 +0100
Subject: [RFC PATCH 1/4] regulator: Introduce OMAP regulator to control
 PMIC over VC/VP
In-Reply-To: <CAGo_u6qTiPpd0DDe3jnPh_UxTwox22azhcMGy=fftL8H+DGeyw@mail.gmail.com>
References: <1369246717-4167-1-git-send-email-nm@ti.com>
 <1369246717-4167-2-git-send-email-nm@ti.com>
 <20130610103131.GR31367@sirena.org.uk>
 <CAGo_u6qTiPpd0DDe3jnPh_UxTwox22azhcMGy=fftL8H+DGeyw@mail.gmail.com>
Message-ID: <20130610164905.GJ1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 11:16:59AM -0500, Nishanth Menon wrote:
> On Mon, Jun 10, 2013 at 5:31 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Wed, May 22, 2013 at 01:18:34PM -0500, Nishanth Menon wrote:

> > So, the biggest problem here has been patch 4 (having to have a hack to
> > deploy this stuff is a bit worrying) plus the general not having a real
> > driver thing.

> Patch #4 in this series was a hack as it was not properly split up and
> organized as a proper DTS series -it was meant as a proof of concept -
> not entirely meant to indicate the remaining 1-3 patches were hacks
> :).

The way it reads is that you're building up to a hack - if what you've
done isn't enabling a sensible solution there might be a problem with
the earlier steps.

> I think you mean http://marc.info/?t=137059249100003&r=1&w=2 series. I
> will dig into it. if it is possible for Tegra and OMAP to use the same
> framework and strategy to deal with these kind of h/w blocks, all the
> more better.

Not just better, if each system doing this sort of thing needs to
reinvent the wheel something is going wrong.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130610/7376fb78/attachment.sig>
