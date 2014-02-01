From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 31 Jan 2014 19:06:14 -0800
Subject: [RFC] dt-bindings: configuration of parent clocks and clock
 frequency
In-Reply-To: <52DE6CAB.10008@samsung.com>
References: <52DE6CAB.10008@samsung.com>
Message-ID: <20140201030614.9977.80501@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sylwester Nawrocki (2014-01-21 04:48:43)
> 5. Similarly to the regulator bindings the clock names could be appended
>   to name of a DT property:
> 
>  [clk_name]-assigned-clock-parent = <...>;
>  [clk_name]-assigned-clock-rate = <...>;

I have always been partial to the way that the reg framework does its
[reg_name]-supply. We could shorten it to something like:

[clk-name]-asn-parent = ....
[clk-name]-asn-rate = ...

This is actually the format that was discussed at the ARM kernel summit
IIRC.

Regards,
Mike
