From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 04 Feb 2014 13:16:07 +0100
Subject: [RFC] dt-bindings: configuration of parent clocks and clock
 frequency
In-Reply-To: <20140201030614.9977.80501@quantum>
References: <52DE6CAB.10008@samsung.com> <20140201030614.9977.80501@quantum>
Message-ID: <52F0DA07.6050903@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-02-01 04:06, Mike Turquette wrote:
> Quoting Sylwester Nawrocki (2014-01-21 04:48:43)
> > 5. Similarly to the regulator bindings the clock names could be appended
> >   to name of a DT property:
> >
> >  [clk_name]-assigned-clock-parent = <...>;
> >  [clk_name]-assigned-clock-rate = <...>;
>
> I have always been partial to the way that the reg framework does its
> [reg_name]-supply. We could shorten it to something like:
>
> [clk-name]-asn-parent = ....
> [clk-name]-asn-rate = ...
>
> This is actually the format that was discussed at the ARM kernel summit
> IIRC.

I think that "[clk-name]-clk-parent" and "[clk-name]-clk-rate" will be a bit
more descriptive names instead of quite ambiguous "asn".

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
