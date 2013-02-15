From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Feb 2013 09:41:12 -0700
Subject: [v3 2/6] ARM: tegra20: convert device tree files to use CLK
 defines
In-Reply-To: <1360917814-27236-3-git-send-email-hdoyu@nvidia.com>
References: <1360917814-27236-1-git-send-email-hdoyu@nvidia.com>
 <1360917814-27236-3-git-send-email-hdoyu@nvidia.com>
Message-ID: <511E6528.1060007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2013 01:43 AM, Hiroshi Doyu wrote:
> Replace magic number in tegra_car:
> 
> -               clocks = <&tegra_car 28>;
> +               clocks = <&tegra_car CLK_HOST1X>;
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
>  .../bindings/clock/nvidia,tegra20-car.txt          |  150 +-------------------

The edits to the binding are logically part of patch 1.
