From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 13 Jul 2015 15:03:43 +0100
Subject: [PATCH V3 19/19] ARM: tegra: select PM_GENERIC_DOMAINS
In-Reply-To: <20150713135047.GR6287@tbergstrom-lnx.Nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-20-git-send-email-jonathanh@nvidia.com>
 <20150713135047.GR6287@tbergstrom-lnx.Nvidia.com>
Message-ID: <55A3C53F.8090003@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/07/15 14:50, Peter De Schrijver wrote:
> On Mon, Jul 13, 2015 at 01:39:57PM +0100, Jon Hunter wrote:
>> From: Vince Hsu <vinceh@nvidia.com>
>>
>> We have added generic power domain support for Tegra SoCs. So now the
>> option M_GENERIC_DOMAINS must be enabled by default to have proper power
> 
> Missing P :)

Ooops. I think introduced that error. Will fix.

Cheers
Jon
