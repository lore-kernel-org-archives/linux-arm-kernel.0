From: philippe.retornaz@epfl.ch (Philippe =?iso-8859-1?q?R=E9tornaz?=)
Date: Tue, 10 Aug 2010 10:45:03 +0200
Subject: [regression] in linux-next: sh_mobile_ceu_camera broken by "ARM:
	Prohibit ioremap() on kernel managed RAM"
In-Reply-To: <4C5ED116.5000002@arndnet.de>
References: <4C5ED116.5000002@arndnet.de>
Message-ID: <201008101045.03547.philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le dimanche, 8 ao?t 2010 17.45:26, Arnd Hannemann a ?crit :
> Hi Russell,
> 
> your commit 309caa9cc6ff39d261264ec4ff10e29489afc8f8
> ARM: Prohibit ioremap() on kernel managed RAM
> 
> lets drivers/base/dma-coherent.c::dma_declare_coherent_memory()
> fail for the sh_mobile_ceu_camera driver (see backtrace below).
> I think, other configurations (i.MX31 users of the mx3_camera driver:
> pcm037 and mx31moboard) will have the same problem.
> 
> Since I have no idea how to fix this, I post this regression report here...

Have you found a solution to this problem ? As you said, the mx3_camera driver 
doesn't work anymore on mx31moboard.

Thanks ! 

Philippe
