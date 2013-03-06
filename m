From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 06 Mar 2013 14:56:22 -0700
Subject: [PATCH V2 0/4] ARM: tegra114: bring up secondary CPU for SMP
In-Reply-To: <1361932087-13372-1-git-send-email-josephl@nvidia.com>
References: <1361932087-13372-1-git-send-email-josephl@nvidia.com>
Message-ID: <5137BB86.80200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2013 07:28 PM, Joseph Lo wrote:
> This series bring up secondary CPU for Tegra114. Because we are going to
> support generic power domain later, the conventional powergate driver will
> be removed. So we add the CPU power on/off function in PMC driver first.

I have applied all 4 patches in this series:

1/4: Applied V3, to Tegra's for-3.10/cleanup branch
2/4: Applied V3, to Tegra's for-3.10/cleanup branch
3/4: Applied V2, to Tegra's for-3.10/cleanup branch
4/4: Applied V2, to Tegra's for-3.10/soc branch
