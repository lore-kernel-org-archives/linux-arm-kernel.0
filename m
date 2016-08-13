From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 12 Aug 2016 17:39:13 -0700
Subject: [PATCH v9 01/10] clk: fix initial state of critical clock's
 parents
In-Reply-To: <1470989873.8551.10.camel@mtksdaap41>
References: <1466581229-2342-1-git-send-email-erin.lo@mediatek.com>
 <1466581229-2342-2-git-send-email-erin.lo@mediatek.com>
 <20160702012140.GB17071@codeaurora.org>
 <1467604308.26485.4.camel@mtksdaap41>
 <146802073038.73491.6675612765998057903@resonance>
 <1468225452.31247.7.camel@mtksdaap41>
 <1470203182.17063.3.camel@mtksdaap41>
 <1470721183.8551.6.camel@mtksdaap41>
 <20160810210922.GD2996@codeaurora.org>
 <1470989873.8551.10.camel@mtksdaap41>
Message-ID: <20160813003913.GA361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12, James Liao wrote:
> On Wed, 2016-08-10 at 14:09 -0700, Stephen Boyd wrote:
> > (Including lists)
> > 
> > On 08/09, James Liao wrote:
> > > On Wed, 2016-08-03 at 13:46 +0800, James Liao wrote:
> > >>
> > >> Hi Mike,
> > >>
> > >> Do you have new patches to fix new clock parents? If not, I think we can
> > >> use my patch first. Is it okay?
> > >>
> > >
> > > Hi Stephen,
> > >
> > > Do you have comments for the bug fixing? I prefer to use my patch (clk:
> > > fix initial state of critical clock's parents). How do you think?
> > >
> > 
> > How about we recalc accuracies and rates in addition to the patch
> > from Mike? That will fix everything?
> 
> Hi Stephen,
> 
> It works!
> 
> I'll send a new series of MT2701 clock support in few days. Should I
> include this patch in my series? Or you'll merge it into clk-next
> directly?
> 

Thanks. I can take that as a tested-by? I can merge it into
clk-next directly, but do we need to put the mt2701 patches on a
separate branch to merge into arm-soc? If so we'll need to put
this patch first to avoid bisection failures.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
