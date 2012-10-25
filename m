From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 25 Oct 2012 20:54:00 +0000 (UTC)
Subject: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add read_reset_sources
 pdata function pointer (fwd)
In-Reply-To: <20121023080533.GA16482@spo001.leaseweb.com>
References: <alpine.DEB.2.00.1210180125140.30902@utopia.booyaka.com>
 <20121023080533.GA16482@spo001.leaseweb.com>
Message-ID: <alpine.DEB.2.00.1210252053250.4745@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wim,

On Tue, 23 Oct 2012, Wim Van Sebroeck wrote:

> > When you have the opportunity, could you take a look at this patch, and 
> > the subsequent patch 6/7, and ack them if you're okay with them?
> 
> Signed them off, Acked-by would probably have been better :-).

Great!  Will add your Acked-by:s. 

> > We'd like to merge thse as part of a larger cleanup series through the 
> > arm-soc tree.  They like cleanup patches to arrive at the beginning of the 
> > -rc series, which means that we need to have the pull request sent pretty 
> > soon.
> 
> Please go ahead. The sooner those ifdefs are gone the better.

Thanks Wim,


- Paul
