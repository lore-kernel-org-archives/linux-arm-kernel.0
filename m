From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 14 Apr 2016 06:56:08 +0200
Subject: [PATCH v1] clk: Add clk_composite_set_rate_and_parent
In-Reply-To: <20160414004331.GK14441@codeaurora.org>
References: <1460339652-63498-1-git-send-email-finley.xiao@rock-chips.com>
 <3986787.PS6VzOpSAJ@phil> <20160414004331.GK14441@codeaurora.org>
Message-ID: <4176514.rpsd1Fqbyv@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 13. April 2016, 17:43:31 schrieb Stephen Boyd:
> On 04/12, Heiko Stuebner wrote:
> > I remember having clocks not overflow their target rate came up in some
> > ELC
> > talk last week (probably in Stephens Qualcomm-kernel-talk) and a general
> > solution might need some changes closer to the core.
> 
> Yep. It's on the list. Hopefully coordinated clk rate changes
> will help here. Composite clks are sort of already coordinated
> rates in a minor form though.

Which is why I hope we can land this (meaning v2 from tuesday) in the 
meantime, as it fixes an issue we're seeing on the rk3399 and shouldn't affect 
any part of the core clock-framework ;-) .


Heiko
