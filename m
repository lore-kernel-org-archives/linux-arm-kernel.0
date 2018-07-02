From: rdunlap@infradead.org (Randy Dunlap)
Date: Mon, 2 Jul 2018 09:41:16 -0700
Subject: linux-next: Tree for Jul 2 (sound/soc/pxa/)
In-Reply-To: <2276786f-3f50-0740-0500-68a26a49704a@infradead.org>
References: <20180702145158.10190101@canb.auug.org.au>
 <2276786f-3f50-0740-0500-68a26a49704a@infradead.org>
Message-ID: <c12cc7c4-03d0-4b0b-d02f-7e72b8a135d4@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[add other maintainers]

On 07/02/18 09:09, Randy Dunlap wrote:
> On 07/01/18 21:51, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20180629:
>>
> 
> on i386 or x86_64:
> 
> builtin:
> sound/soc/pxa/pxa-ssp.o:(.rodata+0x228): undefined reference to `pxa2xx_soc_pcm_new'
> sound/soc/pxa/pxa-ssp.o:(.rodata+0x22c): undefined reference to `pxa2xx_pcm_free_dma_buffers'
> sound/soc/pxa/pxa-ssp.o:(.rodata+0x250): undefined reference to `pxa2xx_pcm_ops'
> /home/rdunlap/lnx/next/linux-next-20180702/Makefile:1023: recipe for target 'vmlinux' failed
> 
> modular:
> ERROR: "pxa2xx_pcm_ops" [sound/soc/pxa/snd-soc-pxa-ssp.ko] undefined!
> ERROR: "pxa2xx_pcm_free_dma_buffers" [sound/soc/pxa/snd-soc-pxa-ssp.ko] undefined!
> ERROR: "pxa2xx_soc_pcm_new" [sound/soc/pxa/snd-soc-pxa-ssp.ko] undefined!
> 
> 
> x86_64 [modular] randconfig file is attached.
> 


-- 
~Randy
