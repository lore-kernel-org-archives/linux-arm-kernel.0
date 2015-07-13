From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 13 Jul 2015 15:02:54 +0100
Subject: [PATCH V3 06/19] clk: tegra: remove TEGRA_PLL_USE_LOCK for
 PLLD/PLLD2
In-Reply-To: <20150713134151.GQ6287@tbergstrom-lnx.Nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-7-git-send-email-jonathanh@nvidia.com>
 <20150713134151.GQ6287@tbergstrom-lnx.Nvidia.com>
Message-ID: <55A3C50E.7060706@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/07/15 14:41, Peter De Schrijver wrote:
> On Mon, Jul 13, 2015 at 01:39:44PM +0100, Jon Hunter wrote:
>> From: Vince Hsu <vinceh@nvidia.com>
>>
>> Tegra114 has a HW bug that the PLLD/PLLD2 lock bit cannot be asserted when
>> the DIS power domain is during up-powergating process but the clamp to this
> 
> I think there is missing 'off' in this sentence?
> 
> ie. ... 'the DIS power domain is off during up-powergating process'
> 
> Also 'un-powergating sequence' would be nicer.

Yes agree. I will re-word that.

Thanks
Jon
