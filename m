From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 16 Apr 2014 17:14:37 -0600
Subject: [PATCH] ARM: tegra: fix Jetson TK1 SD card supply
In-Reply-To: <1397666945-8779-1-git-send-email-swarren@wwwdotorg.org>
References: <1397666945-8779-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <534F0EDD.8050407@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2014 10:49 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Regulator vddio_sdmmc3 provides the Tegra<->SD IO voltage, not the card
> core supply voltage. That is, it provides vqmmc, not vmmc. Fix the DT to
> correctly reflect this.

I've applied this to Tegra's for-3.16/dt branch.
