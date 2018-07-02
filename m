From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 02 Jul 2018 21:22:45 +0200
Subject: linux-next: Tree for Jul 2 (sound/soc/pxa/)
In-Reply-To: <c12cc7c4-03d0-4b0b-d02f-7e72b8a135d4@infradead.org> (Randy
 Dunlap's message of "Mon, 2 Jul 2018 09:41:16 -0700")
References: <20180702145158.10190101@canb.auug.org.au>
 <2276786f-3f50-0740-0500-68a26a49704a@infradead.org>
 <c12cc7c4-03d0-4b0b-d02f-7e72b8a135d4@infradead.org>
Message-ID: <87h8lhh27u.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Randy Dunlap <rdunlap@infradead.org> writes:
> [add other maintainers]
> on i386 or x86_64:
> 
> builtin:
> sound/soc/pxa/pxa-ssp.o:(.rodata+0x228): undefined reference to `pxa2xx_soc_pcm_new'
> sound/soc/pxa/pxa-ssp.o:(.rodata+0x22c): undefined reference to `pxa2xx_pcm_free_dma_buffers'
> sound/soc/pxa/pxa-ssp.o:(.rodata+0x250): undefined reference to `pxa2xx_pcm_ops'

Hi Randy,

I think the fix is already queued in Mark's tree, the commit message should be
"ASoC: pxa: select SND_PXA2XX_LIB for drivers that depend on it".

Adding Daniel as he is the original author.

Cheers.

--
Robert
