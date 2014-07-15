From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Jul 2014 08:55:15 +0200
Subject: [PATCH v4 3/6] mfd: sun6i-prcm: Add support for Allwinner A23 PRCM
In-Reply-To: <20140710093707.GC11948@lee--X1>
References: <1404892479-12222-1-git-send-email-wens@csie.org>
 <1404892479-12222-4-git-send-email-wens@csie.org>
 <20140710093707.GC11948@lee--X1>
Message-ID: <20140715065515.GE3745@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Thu, Jul 10, 2014 at 10:37:07AM +0100, Lee Jones wrote:
> On Wed, 09 Jul 2014, Chen-Yu Tsai wrote:
> 
> > The Allwinner A23 SoC has a PRCM unit like the previous A31 SoC.
> > The differences are the AR100 clock can no longer be modified,
> > the APB0 clock has different divisors, and some clock gates are
> > gone.
> > 
> > This patch adds a compatible with a modified subdevice list for
> > the A23.
> > 
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  .../devicetree/bindings/mfd/sun6i-prcm.txt         |  2 +-
> >  drivers/mfd/sun6i-prcm.c                           | 30 ++++++++++++++++++++++
> >  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

We don't have any dependency on this driver, so it would be simpler if
you could just take it through your tree I guess.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140715/83aeb343/attachment.sig>
