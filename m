From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 30 May 2014 11:10:43 +0300
Subject: [RFC PATCH] clk: flatten clk tree in debugfs
In-Reply-To: <538656C1.3090402@codeaurora.org>
References: <1400842772-4862-1-git-send-email-pdeschrijver@nvidia.com>
 <537FCAA0.6080106@codeaurora.org>
 <20140526111453.GE5961@tbergstrom-lnx.Nvidia.com>
 <53862142.8080006@codeaurora.org> <20140528185210.10062.16299@quantum>
 <538656C1.3090402@codeaurora.org>
Message-ID: <20140530081043.GO5961@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>
> >> Mike, others,
> >>
> >> Any objections to this idea? If there's not much opposition, then maybe
> >> Peter can actually spend time fixing and testing this patch?
> >
> > Idea seems fine. I had actually considered removing the hiearchal
> > directory structure completely with the advent of clk_dump and
> > clk_summary, but if there is value in the flattened directory structure
> > then I'm all for it.
> I think the additional value of the flattened directory probably comes 
> from internal tree patches that would add set rate capability to clocks, 
> etc that would be helpful with testing.
> 

Yes. Eg. I posted a patch to dump a clocks registers for Tegra.

> Agree with all the comments so far.
> 
> Peter,
> 
> Looks like there's some support and no opposition so far. So do you want 
> to send out a real patch that's been tested and with the comments above 
> taken care of?

Yes. I will do that.

Cheers,

Peter.
