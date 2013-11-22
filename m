From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 22 Nov 2013 15:45:18 +0200
Subject: [PATCH 1/5] clk: tegra: fix blink clock rate
In-Reply-To: <1384991242-13596-1-git-send-email-swarren@wwwdotorg.org>
References: <1384991242-13596-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131122134518.GF26617@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 12:47:18AM +0100, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The blink clock rate needs to be configured, or it will run at ~1Hz
> rather than the desired 32KHz. If it runs at the wrong rate, e.g. the
> SDIO WiFi on Seaboard and Cardhu will fail to be detected.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This probably needs to be squashed into commit 32721a734a3d "clk: tegra:
> move PMC, fixed clocks to common files".
> ---

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>

I will squash this into the mentioned commit.

Cheers,

Peter.
