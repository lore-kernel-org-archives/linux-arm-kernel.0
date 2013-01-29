From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 29 Jan 2013 11:10:15 -0700
Subject: [PATCH 6/7] ARM: DT: tegra114:add aliases and DMA requestor for
 serial controller
In-Reply-To: <1359464183-6255-7-git-send-email-ldewangan@nvidia.com>
References: <1359464183-6255-1-git-send-email-ldewangan@nvidia.com>
 <1359464183-6255-7-git-send-email-ldewangan@nvidia.com>
Message-ID: <51081087.5040801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2013 05:56 AM, Laxman Dewangan wrote:
> Add APB DMA requestor and serial aliases for serial controller.
> There will be two serial driver i.e. 8250 based simple serial driver
> and APB DMA based serial driver for higher baudrate and performace.
> 
> The simple serial driver get enabled with compatible nvidia,tegra20-uart
> and APB DMA based driver will get enabled with compatible
> nvidia,tegra30-hsuart.

I also can't apply this patch yet since it depends on the APB DMA DT
node which as I mentioned I'm not apply yet.
