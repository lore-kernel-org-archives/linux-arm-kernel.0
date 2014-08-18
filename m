From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Aug 2014 22:19:29 +0200
Subject: [PATCH] This adds a generic PWM framework driver for the PWM
 controller
In-Reply-To: <CAKON4OwzFDDXqCF4VNkUXXJLp3smrB6Axp_x=D47sjbpoNbe+g@mail.gmail.com>
References: <20140818180316.31807.3445.stgit@studio>
 <20140818192318.GJ15297@lukather>
 <CAKON4OwzFDDXqCF4VNkUXXJLp3smrB6Axp_x=D47sjbpoNbe+g@mail.gmail.com>
Message-ID: <20140818201929.GL15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 03:53:08PM -0400, jonsmirl at gmail.com wrote:
> On Mon, Aug 18, 2014 at 3:23 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Mon, Aug 18, 2014 at 02:03:16PM -0400, Jon Smirl wrote:
> >> found on Allwinner SoCs.x
> >>
> >> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> >
> > Is there any notable difference with Alexandre's driver?
> > https://lkml.org/lkml/2014/5/19/568
> >
> > If so, why didn't you posted incremental patches on top of his driver?
> 
> Better A10 support.

Better how?

> And I wrote this one without know about his.

So you're just require us to trash an already extensively reviewed
driver and start from scratch again?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140818/9e6f1894/attachment-0001.sig>
