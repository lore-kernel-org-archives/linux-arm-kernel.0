From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Wed, 13 Apr 2011 15:11:41 +0200
Subject: [PATCH 2.6.39 v2] V4L: videobuf-dma-contig: fix mmap_mapper
	broken on ARM
In-Reply-To: <4DA59120.1070402@ru.mvista.com>
References: <201104122306.34909.jkrzyszt@tis.icnet.pl>
	<4DA59120.1070402@ru.mvista.com>
Message-ID: <201104131511.42171.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dnia ?roda 13 kwiecie? 2011 o 14:03:44 Sergei Shtylyov napisa?(a):
> Hello.
> 
> On 13-04-2011 1:06, Janusz Krzysztofik wrote:
> > After switching from mem->dma_handle to virt_to_phys(mem->vaddr)
> > used for obtaining page frame number passed to remap_pfn_range()
> > (commit 35d9f510b67b10338161aba6229d4f55b4000f5b),
> > videobuf-dma-contig
> 
>     Please specify the commit summary -- for the human readers.

Hi,
OK, I'll try to reword the summary using a more human friendly language 
as soon as I have signs that Mauro (who seemed to understand the message 
well enough) is willing to accept the code.

Thanks,
Janusz
