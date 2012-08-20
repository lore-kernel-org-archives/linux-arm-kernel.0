From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Aug 2012 20:06:24 +0000
Subject: [PATCH 0/4] Per device coherent DMA map ops
In-Reply-To: <50324F9A.5000608@gmail.com>
References: <1344916147-13546-1-git-send-email-robherring2@gmail.com>
 <000601cd7ede$5d2ef390$178cdab0$%szyprowski@samsung.com>
 <50324F9A.5000608@gmail.com>
Message-ID: <201208202006.24851.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 August 2012, Rob Herring wrote:
> > 
> > I like those patches and I would like to take it to my dma-mapping-next tree, but I wonder 
> > how to handle merging of the last patch. Arnd, Olof - could You tell me how to do it? I assume
> > that it should be somehow merged by arm-soc tree, so it depends on the earlier patches.
> > Would it be enough if I take them to the topic branch? Then I can continue works on 
> > dma-mapping subsystem by merging that topic branch to my dma-mapping-next and you will
> > also take it as a dependency for highbank patches. Am I right?
> > 
> 
> I'm fine with it all going in thru your tree. Seems a bit silly to deal
> with tracking the dependencies all for 1 patch. The only possible
> conflict I see is with the dts file and some other SATA related changes
> which will go in via the ata tree. But the merge is trivial and the
> conflict will be there either with your tree or arm-soc.

Right. I see no problem having this patch go through the dma-mapping tree.

	Arnd
