From: r65037@freescale.com (Zhu Richard-R65037)
Date: Tue, 27 Mar 2012 13:03:08 +0000
Subject: [MX25][MMC] mmc esdhc failure in 3.3
In-Reply-To: <20120327105819.00d89783@eb-e6520>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
 <20120312132423.GC2459@pengutronix.de>
 <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
 <0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
 <a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
 <85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
 <20120327101259.73525f9d@eb-e6520>
 <ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
 <20120327105819.00d89783@eb-e6520>
Message-ID: <0E83723C55F66F43A6041464FE31119D0A26D3@039-SN2MPN1-011.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric:
I'm on my business trip out of my FSL office, can't reproduce this issue on i.MX25 board now.
Sorry about that.

Best Regards
Richard Zhu

-----Original Message-----
From: Eric B?nard [mailto:eric at eukrea.com] 
Sent: 2012?3?27? 3:58
To: joancarles
Cc: Zhu Richard-R65037; shawn.guo at linaro.org; linux-mmc at vger.kernel.org; Wolfram Sang; linux-arm-kernel at lists.infradead.org
Subject: Re: [MX25][MMC] mmc esdhc failure in 3.3

Hi Joan Carles,

Le Tue, 27 Mar 2012 10:46:45 +0200,
joancarles <joancarles@fqingenieria.es> a ?crit :
> >> This is still present, and we have absolutely no idea where to 
> >> continue searching for the solution of the problem. Any pointers? 
> >> Any git trees of mmc driver changes we could try? Anybody else with 
> >> a MX25 that has this issue?
> >>
> > does that attached patch fix your problem ?
> 
> YES, indeed it does to a certain degree. The timeout errors do not 
> occur anymore and I can successfully perform many fs->ops, such as 
> READ, WRITE, UNLINK ... . So thank you very much for this insight 
> through your patch!
> 
> The speed of the card is excruciatingly slow, however. We roughly get 
> between 34KB/s and 64KB/s from a dd if=/dev/zero write to any of the 
> following partitions:
> 
I have the same speed problem here on i.MX25 but still haven't found the reason.
Shawn, Richard : do you have an idea of why the eSDHC is so slow on
i.MX25 ?

Thanks,
Eric
