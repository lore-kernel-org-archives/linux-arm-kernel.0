From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Wed, 13 Apr 2011 23:01:55 +0200
Subject: [PATCH 2.6.39 v2] V4L: videobuf-dma-contig: fix mmap_mapper
	broken on ARM
In-Reply-To: <4DA5DF1E.1040302@ru.mvista.com>
References: <201104122306.34909.jkrzyszt@tis.icnet.pl>
	<201104131511.42171.jkrzyszt@tis.icnet.pl>
	<4DA5DF1E.1040302@ru.mvista.com>
Message-ID: <201104132301.56210.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dnia ?roda 13 kwiecie? 2011 o 19:36:30 Sergei Shtylyov napisa?(a):
> Hello.
> 
> Janusz Krzysztofik wrote:
> >>> After switching from mem->dma_handle to virt_to_phys(mem->vaddr)
> >>> used for obtaining page frame number passed to remap_pfn_range()
> >>> (commit 35d9f510b67b10338161aba6229d4f55b4000f5b),
> >>> videobuf-dma-contig
> >>> 
> >>     Please specify the commit summary -- for the human readers.
> > 
> > Hi,
> > OK, I'll try to reword the summary using a more human friendly
> > language as soon as I have signs that Mauro (who seemed to
> > understand the message well enough) is willing to accept the code.
> 
>     I wasn't asking you to rework your summary but to specify the
> summary of the commit you've mentioned (in parens).

Ah, I see. How about just reordered wording:

After commit 35d9f510b67b10338161aba6229d4f55b4000f5b (switching from 
mem->dma_handle to virt_to_phys(mem->vaddr) used for obtaining page 
frame number passed to remap_pfn_range()), ....

Do you think this would be clear enough?

Thanks,
Janusz
