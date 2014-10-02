From: b.galvani@gmail.com (Beniamino Galvani)
Date: Thu, 2 Oct 2014 19:08:48 +0200
Subject: [PATCH 1/6] ARM: meson: add meson8 machine definition
In-Reply-To: <6568653.UtyvOjrQBb@wuerfel>
References: <1412198986-26534-1-git-send-email-b.galvani@gmail.com>
 <1412198986-26534-2-git-send-email-b.galvani@gmail.com>
 <6568653.UtyvOjrQBb@wuerfel>
Message-ID: <20141002170848.GB29052@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 02, 2014 at 11:28:14AM +0200, Arnd Bergmann wrote:
> On Wednesday 01 October 2014 23:29:41 Beniamino Galvani wrote:
> >  DT_MACHINE_START(AML8726_MX, "Amlogic Meson6 platform")
> >         .dt_compat      = m6_common_board_compat,
> >  MACHINE_END
> >  
> > +DT_MACHINE_START(MESON8, "Amlogic Meson8 platform")
> > +       .dt_compat      = m8_common_board_compat,
> > +MACHINE_END
> 
> One more thing: since this is a cortex-a9, don't you have to enable
> the l2x0 cache controller explicitly? I think you need a
> ".l2c_aux_mask   = ~0," entry here.

Will do, thanks.

Beniamino
