From: joelf@ti.com (Joel Fernandes)
Date: Mon, 12 Aug 2013 13:19:18 -0500
Subject: [PATCH v3 08/12] dma: edma: Add one more required slot to MAX
 slots
In-Reply-To: <20130812133111.GZ6427@sirena.org.uk>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
 <1375719297-12871-9-git-send-email-joelf@ti.com> <52087921.8040101@ti.com>
 <20130812133111.GZ6427@sirena.org.uk>
Message-ID: <52092726.7030505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2013 08:31 AM, Mark Brown wrote:
> On Mon, Aug 12, 2013 at 11:26:49AM +0530, Sekhar Nori wrote:
> 
>> No need for a separate patch for this, just do this in the patch where
>> you include the two linked sets.
> 
> Can you guys please think about the CC lists you're using for these
> patch serieses?  I've certainly no interest in random patches to the
> DaVinci DMA controllers, and I suspect the same is true for most of the
> people on the CC list.
> 

Sorry. I was actually getting a sense of this. What I did initially was
I copied the CC list from last years work on the same series hoping that
it would be a complete mail chain. Bad judgement on my part.
I should have paid more attention to Mark's rants about his inbox
getting spammed with this series in those old threads ;)

I guess moving forward I will use get_maintainer.pl and refine my
git-send scripts with only interested folks. Any words of advice on when
to and when not to CC someone remotely connected to a series is welcome.

@Sekhar, let's keep only linux-omap, linux-davinci and few other
interested folks on the CC chain for the rest of review on the series.

Thanks,

-Joel
