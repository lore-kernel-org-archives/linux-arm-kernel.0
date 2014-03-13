From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 13 Mar 2014 13:09:50 +0000
Subject: [PATCH v2 2/3] mfd: sec-core: Add of_compatible strings for MFD
 cells
In-Reply-To: <1394714991.20773.5.camel@AMDC1943>
References: <1394703425-6462-1-git-send-email-k.kozlowski@samsung.com>
 <1394703425-6462-3-git-send-email-k.kozlowski@samsung.com>
 <53219F80.9000300@samsung.com> <1394712996.20773.1.camel@AMDC1943>
 <5321A6A2.9070509@samsung.com> <1394714991.20773.5.camel@AMDC1943>
Message-ID: <20140313130950.GB10356@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<snip>

> > >> Are these compatible strings documented anywhere?
> > >
> > > The "-clk" compatible strings are (in next patch). The "-rtc" and
> > > "-regulators" are not.
> > 
> > Hmm, this doesn't sound good.
> > 
> > > Actually they aren't also used by child driver (each child driver parses
> > > from parent of_node).
> > 
> > Do you need to add compatible strings to mfd_cell entries of such cells 
> > then?
> 
> From my point of view there isn't any special need for them (except for
> clk).
> 
> Dear Lee,
> 
> Do you wish to have these compatibles for all of child drivers even when
> they aren't used directly by them? If yes then probably I should
> document them.

It's your call, either remove the unused ones or document them all.

I don't really mind either way. In the previous version I asked if
there was any reason why you weren't applying compatible strings to
the other cells; "subordinate drivers don't use them" is a perfectly
reasonable reason.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
