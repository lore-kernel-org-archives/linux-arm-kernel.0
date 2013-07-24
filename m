From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Jul 2013 16:40:54 +0530
Subject: [PATCH V2] ARM: dts: tegra114: dalmore: fix the irq trigger type
 of Palmas MFD device
In-Reply-To: <1374663272-9937-1-git-send-email-josephl@nvidia.com>
References: <1374663272-9937-1-git-send-email-josephl@nvidia.com>
Message-ID: <51EFB63E.30003@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 July 2013 04:24 PM, Joseph Lo wrote:
> The IRQ trigger type of Palmas MFD device (tps65913) is edge trigger. The
> wrong configuration would cause an interrupt storm when booting the
> system. Fixing it in DT with appropriate interrupt type.
>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>   
Tested by: Laxman Dewangan <ldewangan@nvidia.com>
