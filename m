From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Tue, 14 Jan 2014 04:10:56 +0000
Subject: Possible regression of Mackerel/ASoC Simple Card in next-20130107
In-Reply-To: <20140114022353.GA7053@verge.net.au>
References: <20140108040017.GA11231@verge.net.au>
 <20140114022353.GA7053@verge.net.au>
Message-ID: <4d593a7756024226a22d93cce2b78b9c@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi 

> >
> > I noticed that next-20130107 does not boot on the Mackerel board does not
> > boot using its defconfig. The boot log is as follows.
> >
> > I have not investigated any further as typically when I investigate
> > problems in next they turn out to be known problems.
> 
> This problem does not appear to be present any more in next-20140113.
> 
 
Maybe the following patch fixed this if the dts is not using.

"ASoC: simple-card: fix a bug where cinfo will be NULL before using it"

Thanks,
