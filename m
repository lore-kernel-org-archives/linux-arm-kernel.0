From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 17 Aug 2012 13:26:51 -0600
Subject: [PATCH] ARM: tegra30: clocks: fix the wrong
 tegra_audio_sync_clk_ops name
In-Reply-To: <1345186450-4517-1-git-send-email-josephl@nvidia.com>
References: <1345186450-4517-1-git-send-email-josephl@nvidia.com>
Message-ID: <502E9AFB.3090205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2012 12:54 AM, Joseph Lo wrote:
> It should use tegra30_audio_sync_clk_ops for tegra30. It will cause
> the tegra30 use the wrong audio_sync_clk_ops when build a kernel with
> a tegra20 and tegra30 both supported kernel. And building error when
> a tegra30-only kernel.

Thanks, applied to Tegra's for-3.7/common-clk branch.
