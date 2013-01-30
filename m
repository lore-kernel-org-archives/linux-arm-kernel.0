From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 30 Jan 2013 09:24:51 +0530
Subject: [PATCH 3/7] ARM: DT: tegra114: add APB DMA controller DT entry
In-Reply-To: <510809FC.2080806@wwwdotorg.org>
References: <1359464183-6255-1-git-send-email-ldewangan@nvidia.com>
 <1359464183-6255-4-git-send-email-ldewangan@nvidia.com>
 <510809FC.2080806@wwwdotorg.org>
Message-ID: <5108998B.4040809@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013 11:12 PM, Stephen Warren wrote:
> On 01/29/2013 05:56 AM, Laxman Dewangan wrote:
>> NVIDIA's Tegra114 has 32 channels APB DMA controller. Add DT entry for
>> APB DMA controllers and make it compatible with "nvidia,tegra114-apbdma".
> The APB DMA controller node needs a clocks property. The same goes for
> I2C and KBC. I'd like to avoid merging those 3 patches until the
> Tegra114 clock patches are present, since the nodes won't be useful
> until then anyway. I expect the clock patches will be merged in 3.10.
>

I think clock patches can be posted on top of this as Peter is working. 
Although, the driver will fail in clk_get() but still I think this can 
be apply to populate the dts file with controller specific information.
