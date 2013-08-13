From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 13 Aug 2013 06:52:56 +0200 (CEST)
Subject: [PATCH 1/16 v2] sound/soc/pxa/mioa701_wm9713.c: Avoid using
 ARRAY_AND_SIZE(e) as a function argument
In-Reply-To: <20130812214050.GI6427@sirena.org.uk>
References: <1376340564-7975-1-git-send-email-Julia.Lawall@lip6.fr>
 <20130812214050.GI6427@sirena.org.uk>
Message-ID: <alpine.DEB.2.02.1308130652080.1997@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Aug 2013, Mark Brown wrote:

> On Mon, Aug 12, 2013 at 10:49:24PM +0200, Julia Lawall wrote:
> > From: Julia Lawall <Julia.Lawall@lip6.fr>
> > 
> > Replace ARRAY_AND_SIZE(e) in function argument position to avoid hiding the
> > arity of the called function.
> 
> What is the difference between this and the patch I applied the other
> day?

Sorry, it should have also removed the local definition of ARRAY_AND_SIZE?  
I thought that was in the commit message.

julia
