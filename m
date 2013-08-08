From: wni@nvidia.com (Wei Ni)
Date: Thu, 8 Aug 2013 10:36:25 +0800
Subject: [PATCH 2/2] ARM: dt: t114 dalmore: add dt entry for nct1008
In-Reply-To: <52026FEE.9070003@wwwdotorg.org>
References: <1375858358-15070-1-git-send-email-wni@nvidia.com>
 <1375858358-15070-3-git-send-email-wni@nvidia.com>
 <52026FEE.9070003@wwwdotorg.org>
Message-ID: <52030429.7010400@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 12:03 AM, Stephen Warren wrote:
> On 08/07/2013 12:52 AM, Wei Ni wrote:
>> Enable thermal sensor nct1008 for t114 dalmore.
> 
> Wei, I assume this patch doesn't depend on any of the other LM90-related
> patches you've sent; I can simply apply it right away?

In my [PATCH 1/2], I add codes to get the vdd regulator and enable it,
so if without it, the lm90 can't work properly on Dalmore, although it
can be loaded.
I think it's better to wait my fist patch applied.

> 
> Is the LM90 DT binding fully documented somewhere, including the
> vdd-supply property?

No LM90 DT binding document yet, I will add it in my next version.

> 
