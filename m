From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 17 Feb 2014 13:48:13 +0100
Subject: [PATCH] arm: omap3: cm-t35: remove MACH_CM_T3730
In-Reply-To: <5302017F.40900@compulab.co.il>
References: <1392571560.28866.16.camel@x220> <5302017F.40900@compulab.co.il>
Message-ID: <1392641293.13000.9.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Igor,

On Mon, 2014-02-17 at 14:33 +0200, Igor Grinberg wrote:
> On 02/16/14 19:26, Paul Bolle wrote:
> > The Kconfig symbol MACH_CM_T3730 was added in v3.1. It has never been
> > used. Setting it has no effect. There are no calls for
> > machine_is_cm_t3730(). This symbol can safely be removed.
> 
> Indeed...

Please note that I now doubt my reasoning was correct here. I'm going to
revisit my recent batch of patches regarding, in short, arm Kconfig
symbols used in mach-types.h. (lkml.org is sort of down, so I can't
provide a link.)

> Is it such a burden to keep it just until we switch OMAP3 to DT?
> Because, it makes a bit harder to hack on the kernel.
> Well, not too much as it can be reverted, but still one needs
> to remember to do this...

No, not really. The worst that could happen, from your perspective, is
that if it turns out this was the right thing to do, I might send a
reminder in a few months.

> I'd like to keep it just until we remove the board files, please.

Thanks,


Paul Bolle
