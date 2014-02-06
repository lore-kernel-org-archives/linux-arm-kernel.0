From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 06 Feb 2014 08:43:05 -0800
Subject: [RFC] dt-bindings: configuration of parent clocks and clock
 frequency
In-Reply-To: <52F0DA07.6050903@samsung.com>
References: <52DE6CAB.10008@samsung.com> <20140201030614.9977.80501@quantum>
 <52F0DA07.6050903@samsung.com>
Message-ID: <20140206164305.22158.43488@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Marek Szyprowski (2014-02-04 04:16:07)
> Hello,
> 
> On 2014-02-01 04:06, Mike Turquette wrote:
> > Quoting Sylwester Nawrocki (2014-01-21 04:48:43)
> > > 5. Similarly to the regulator bindings the clock names could be appended
> > >   to name of a DT property:
> > >
> > >  [clk_name]-assigned-clock-parent = <...>;
> > >  [clk_name]-assigned-clock-rate = <...>;
> >
> > I have always been partial to the way that the reg framework does its
> > [reg_name]-supply. We could shorten it to something like:
> >
> > [clk-name]-asn-parent = ....
> > [clk-name]-asn-rate = ...
> >
> > This is actually the format that was discussed at the ARM kernel summit
> > IIRC.
> 
> I think that "[clk-name]-clk-parent" and "[clk-name]-clk-rate" will be a bit
> more descriptive names instead of quite ambiguous "asn".

+1

Regards,
Mike

> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
