From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 26 Nov 2012 14:00:28 -0700
Subject: [PATCH 1/1] arm: tegra: fix comment in dsib clk set_parent
In-Reply-To: <1353498147-14574-1-git-send-email-sivaramn@nvidia.com>
References: <1353498147-14574-1-git-send-email-sivaramn@nvidia.com>
Message-ID: <50B3D86C.40104@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2012 04:42 AM, Sivaram Nair wrote:
> Since the clk framework has already taken necessary locks before calling
> into the arch clk ops code, no further locks are needed while setting
> the parent of dsib clk. This patch removes a comment that indicated
> otherwise, and yet did not take any locks.

Thanks, applied.
