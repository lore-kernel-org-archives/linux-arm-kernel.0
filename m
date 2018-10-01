From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 1 Oct 2018 15:17:44 +0200
Subject: [PATCH] MAINTAINERS: Drop dt-bindings/genpd/k2g.h
In-Reply-To: <19176740-b38f-8ae9-a9a2-85d6f7a9c590@oracle.com>
References: <20180928224615.19862-1-nm@ti.com>
 <19176740-b38f-8ae9-a9a2-85d6f7a9c590@oracle.com>
Message-ID: <CAK8P3a0CqDFbNOcLH-mEGfxb2HyzDNiuUWf5zAo1ndehQs9S2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 29, 2018 at 2:07 AM Santosh Shilimkar
<santosh.shilimkar@oracle.com> wrote:
> On 9/28/2018 3:46 PM, Nishanth Menon wrote:
> > Drop include/dt-bindings/genpd/k2g.h which disappeared from kernel tree
> > some time back, however MAINTAINERS file was missed to be updated.
> >
> > Fixes: d16645054d2f ("dt-bindings: Drop k2g genpd device ID macros")
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Dave Gerlach <d-gerlach@ti.com>
> > Cc: Santosh Shilimkar <ssantosh@kernel.org>
> > Cc: Tero Kristo <t-kristo@ti.com>
> > Reported-by: Joe Perches <joe@perches.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >
> > A big oops.. Sorry about that. will do better next time. I tried to relook and
> > I think we have'nt missed any other files.
> >
> > Based off next-20180928 tag.
> >
> > Santosh, any chance you could pick this up -> Thread:
> > https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1776470.html
> >
> Could you please apply this to arm-soc tree if its not too
> late ?
>
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

Applied to next/soc, thanks!

      Arnd
