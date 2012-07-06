From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 6 Jul 2012 13:39:32 +0200 (CEST)
Subject: [PATCH v3][for_v3.5] media: mx2_camera: Fix mbus format handling
In-Reply-To: <CACKLOr0nwKoO4UL9MKZJmD9WN1uyJhpNzAybd7w7x-GnLtM5cw@mail.gmail.com>
References: <1338543105-20322-1-git-send-email-javier.martin@vista-silicon.com>
 <CACKLOr0J1JjpCMRf4toJ5uBMDAFZT8VGdFuX6MpUpxpNaAO_SA@mail.gmail.com>
 <Pine.LNX.4.64.1207061308300.29809@axis700.grange>
 <CACKLOr0nwKoO4UL9MKZJmD9WN1uyJhpNzAybd7w7x-GnLtM5cw@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.1207061338170.29809@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 6 Jul 2012, javier Martin wrote:

> Hi Guennadi,
> 
> On 6 July 2012 13:09, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > On Fri, 6 Jul 2012, javier Martin wrote:
> >
> >> Hi,
> >> can this patch be applied please?
> >>
> >> It solves a BUG for 3.5. Guennadi, Fabio, could you give me an ack for this?
> >
> > Sorry? This patch has been applied and proven to break more, than it
> > fixed, so, it has been reverted. Am I missing something?
> 
> Patch v1 was the version that broke pass-through mode (which nobody
> seems to be using/testing). It was applied, then it was reverted as
> you requested in [1].
> 
> Then I sent v2 that didn't break pass-through but was invalid too
> because of a merge conflict [2].
> 
> Finally, this is v3 which has the pass-through problem and the merge
> problem fixed. It is currently marked as "Under review" and should be
> applied as a fix to 3.5.

Ah, ok, then, don't you think, that expecting your patch to be applied 
within 4 minutes of its submission is a bit... overoptimistic? Because 
it's 4 minutes after your original patch, that you've sent your 
"reminder"...

Thanks
Guennadi

> It can be applied safely since the patch I stated previously is
> already in 3.5-rc5 [4] (it was applied through the imx tree).
> 
> [1] http://patchwork.linuxtv.org/patch/11504/
> [2] http://patchwork.linuxtv.org/patch/11558/
> [3] http://patchwork.linuxtv.org/patch/11559/
> [4] http://patchwork.linuxtv.org/patch/10483/
> --
> Javier Martin
> Vista Silicon S.L.
> CDTUC - FASE C - Oficina S-345
> Avda de los Castros s/n
> 39005- Santander. Cantabria. Spain
> +34 942 25 32 60
> www.vista-silicon.com
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
