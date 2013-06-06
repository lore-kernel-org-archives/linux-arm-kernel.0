From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 06 Jun 2013 10:05:27 -0600
Subject: [PATCH v2 0/4] Override bits for PLLM
In-Reply-To: <1370515677-6807-1-git-send-email-pdeschrijver@nvidia.com>
References: <1370515677-6807-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <51B0B347.7010807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2013 04:47 AM, Peter De Schrijver wrote:
> PLLM has override bits on Tegra30 and Tegra114. This patchset implements
> support for them for both Tegra30 and Tegra114.
> 
> Changes since v1:
>  * Remove some stray lines from 'clk: tegra: override bits for Tegra114 PLLM'

Recall that for V1, I said:

Tested-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Stephen Warren <swarren@nvidia.com>

(assuming the one comment I already made is fixed)

(and according to the changelog above, it has been)
