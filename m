From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 20 Feb 2014 09:59:16 -0700
Subject: [PATCH] clk: tegra124: remove gr2d and gr3d clocks
In-Reply-To: <1392904448-11939-1-git-send-email-pdeschrijver@nvidia.com>
References: <1392904448-11939-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <53063464.2020602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2014 06:54 AM, Peter De Schrijver wrote:
> Tegra124 does not have gr2d and gr3d clocks. They have been replaced by the
> vic03 and gpu clocks respectively.

I think you need to remove the DT #defines from
include/dt-bindings/clock/tegra124-car.h too.

With that change made,
Acked-by: Stephen Warren <swarren@nvidia.com>
(I assume this will be sent as a fix for 3.14)
