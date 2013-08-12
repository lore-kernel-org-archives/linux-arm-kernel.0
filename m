From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 12 Aug 2013 22:24:59 +0200 (CEST)
Subject: [PATCH 9/16] arch/arm/mach-pxa/mioa701.c: Avoid using
 ARRAY_AND_SIZE(e) as a function argument
In-Reply-To: <87r4dyy93t.fsf@free.fr>
References: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
 <1376239917-15594-10-git-send-email-Julia.Lawall@lip6.fr>
 <87r4dyy93t.fsf@free.fr>
Message-ID: <alpine.DEB.2.02.1308122224430.2128@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Aug 2013, Robert Jarzmik wrote:

> Julia Lawall <Julia.Lawall@lip6.fr> writes:
> 
> > From: Julia Lawall <Julia.Lawall@lip6.fr>
> >
> > Replace ARRAY_AND_SIZE(e) in function argument position to avoid hiding the
> > arity of the called function.
> 
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
> 
> As a side I'm curious why this change didn't touch also :
> sound/soc/pxa/mioa701_wm9713.c
> 
> If it does, this ack stands as well for the other file (with removal of the
> #define in mioa701_wm9713.c).

I'll check.  Thanks for the feedback.

julia
