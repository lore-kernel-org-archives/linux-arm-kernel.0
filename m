From: mike.rapoport@gmail.com (Mike Rapoport)
Date: Thu, 5 Nov 2009 00:06:51 +0200
Subject: [PATCH] [ARM] pxa: add U2D registers and bits definitions
In-Reply-To: <f17812d70911040635o1ab53e64s255d031db0de6091@mail.gmail.com>
References: <1257336880-16011-1-git-send-email-grinberg@compulab.co.il>
	<1257336880-16011-2-git-send-email-grinberg@compulab.co.il>
	<f17812d70911040635o1ab53e64s255d031db0de6091@mail.gmail.com>
Message-ID: <f870da180911041406o72fa6890v7209dc86cdd23117@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 4, 2009 at 4:35 PM, Eric Miao <eric.y.miao@gmail.com> wrote:

> On Wed, Nov 4, 2009 at 8:14 PM, Igor Grinberg <grinberg@compulab.co.il>
> wrote:
> >
> > Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> > Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> > ---
> >  arch/arm/mach-pxa/include/mach/regs-u2d.h |  199
> +++++++++++++++++++++++++++++
> >  1 files changed, 199 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-pxa/include/mach/regs-u2d.h
> >
> > diff --git a/arch/arm/mach-pxa/include/mach/regs-u2d.h
> b/arch/arm/mach-pxa/include/mach/regs-u2d.h
>
> Unless there are registers shared between drivers and platform code,
> I'd rather this been kept closer to the driver, include/mach/* is already
> pretty crowded :)
>
> Well, since there's no u2d driver yet it's difficult to keep the register
defines close to it.
Unfortunately we are not woking on u2d and OTG support for pxa3xx, but we
need these register defines to enable at least USB host on CM-X310.


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Sincerely Yours,
Mike.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091105/aabd24e1/attachment-0001.htm>
