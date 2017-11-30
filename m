From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 30 Nov 2017 14:51:31 +0530
Subject: [PATCH v2] dma: stm32: Fix copyright
In-Reply-To: <CAMuHMdVdMrAr8Lu71uMvtW2DnRUX0Y0_Jnr44HSgref7m02=4A@mail.gmail.com>
References: <20171130084249.23196-1-benjamin.gaignard@st.com>
 <CAMuHMdVdMrAr8Lu71uMvtW2DnRUX0Y0_Jnr44HSgref7m02=4A@mail.gmail.com>
Message-ID: <20171130092130.GV32417@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 09:49:34AM +0100, Geert Uytterhoeven wrote:
> Hi Benjamin,
> 
> On Thu, Nov 30, 2017 at 9:42 AM, Benjamin Gaignard
> <benjamin.gaignard@linaro.org> wrote:
> > Uniformize STMicroelectronics copyrights header
> > Add SPDX identifier
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
> > CC: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> > ---
> >  drivers/dma/stm32-dma.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
> > index 786fc8fcc38e..e3187ee9afe9 100644
> > --- a/drivers/dma/stm32-dma.c
> > +++ b/drivers/dma/stm32-dma.c
> > @@ -1,12 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * Driver for STM32 DMA controller
> >   *
> >   * Inspired by dma-jz4740.c and tegra20-apb-dma.c
> >   *
> >   * Copyright (C) M'boumba Cedric Madianga 2015
> > + * Copyright (C) STMicroelectronics 2017
> 
> According to git history, this file wasn't modified by STM in 2017?

or rather ever..

File has 14 non merge commits, 9 from M'boumba Cedric Madianga, 1 from Colin
Ian King and rest yours truely. IANAL but changing copyright here does sound
fishy.. what's going on?

> 
> >   * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> >   *
> > - * License terms:  GNU General Public License (GPL), version 2
> >   */
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
~Vinod
