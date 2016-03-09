From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Wed, 9 Mar 2016 11:08:53 +0100
Subject: [linux-sunxi] Re: [PATCH] dma: sun4i: expose block size and wait
 cycle configuration to DMA users
In-Reply-To: <20160308094625.539646f8@bbrezillon>
References: <1457344771-12946-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160307145429.GG11154@localhost>
 <20160307160857.577bb04d@bbrezillon>
 <20160307203024.GD8418@lukather> <20160308025547.GI11154@localhost>
 <20160308075131.GE8418@lukather>
 <20160308094625.539646f8@bbrezillon>
Message-ID: <20160309100853.GA12312@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > 
> > It doesn't really makes sense to us, but it does have a significant
> > impact on the throughput.
> 
> I wouldn't say significant impact, but tweaking those parameters has
> some impact on the performances, and since it's not that complicated to
> implement, I thought it was worth a try, but maybe I'm wrong.
> 

Hello

I am working on adding DMA on the crypto driver sun4i-ss and I confirm that tweaking those parameter can increase speed.

Regards

LABBE Corentin
