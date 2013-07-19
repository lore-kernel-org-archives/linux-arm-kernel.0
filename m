From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 18 Jul 2013 17:16:05 -0700 (PDT)
Subject: [PATCH 1/3] ARM: shmobile: use common platform header for HPB-DMAC
In-Reply-To: <51E865FA.9000706@cogentembedded.com>
References: <201306300243.57180.sergei.shtylyov@cogentembedded.com>
 <201306300245.58486.sergei.shtylyov@cogentembedded.com>
 <CANqRtoTCaJfbECSpX7nMZoV8SPeQqs-xrJQ0-+-smA+bx3QG=w@mail.gmail.com>
 <51E865FA.9000706@cogentembedded.com>
Message-ID: <87txjrbe11.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

> >> From: Max Filippov <max.filippov@cogentembedded.com>
> 
> >> Use previously empty <mach/dma.h> to declare HPB-DMA slave IDs.
> 
> >> Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
> >> [Sergei: changed the guard macro name, fixed comment, extended copyright.]
> >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >> ---
> >>   arch/arm/mach-shmobile/include/mach/dma.h |   25 ++++++++++++++++++++++++-
> >>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> > Thanks for your patch. Can you please explain the reason why you put
> > this shared information under mach/?
> 
>     I'm afraid that's more a question to the original author, Phil Edworthy.
> He put this stuff into <mach/hpb-dmae.h>.

Then, why you could send this patch instead of original author,
even though you can't answer any question about it ?

Best regards
---
Kuninori Morimoto
