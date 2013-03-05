From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 04 Mar 2013 17:45:25 -0800
Subject: [PATCHv2] ARM: Push selects for TWD/SCU into machine entries
In-Reply-To: <512E9A39.3070207@wwwdotorg.org>
References: <1362007694-3419-1-git-send-email-sboyd@codeaurora.org>
 <512E9A39.3070207@wwwdotorg.org>
Message-ID: <51354E35.1080804@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/13 15:43, Stephen Warren wrote:
>
> Seems simple enough it doesn't really need many, but for Tegra,
> Acked-by: Stephen Warren <swarren@nvidia.com>
>
> Which kernel is this going into? It's possible Tegra will get converted
> to multi-platform in 3.10, which might move that main ARCH_TEGRA block
> from arch/arm/Kconfig into arch/arm/mach-tegra/Kconfig, although I
> suppose it doesn't /have/ to move it. I think some/all(?) other
> multi-platform conversions have moved their main Kconfig option like
> that though.

Thanks. I'm hoping that Arnd/Olof can pick this up. I'm not sure which
version it will go into.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
