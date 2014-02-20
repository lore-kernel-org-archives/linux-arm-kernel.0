From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 20 Feb 2014 10:29:38 -0700
Subject: [PATCH] clk: tegra: Fix vic03 mux index
In-Reply-To: <1392904492-11979-1-git-send-email-pdeschrijver@nvidia.com>
References: <1392904492-11979-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <53063B82.2070200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2014 06:54 AM, Peter De Schrijver wrote:
> The vic03 mux uses a linear mapping.

Reviewed-by: Stephen Warren <swarren@nvidia.com>

(although I'm not sure why the clock is called vic03 rather than just
vic as it is in the TRM, but that's unrelated to this patch)
