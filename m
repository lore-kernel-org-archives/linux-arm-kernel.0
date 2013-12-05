From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 05 Dec 2013 16:33:48 -0700
Subject: [PATCH V3 0/4] ARM: tegra: convert dts files of all Tegra
 platforms to use pinctrl defines
In-Reply-To: <1386240249-30786-1-git-send-email-ldewangan@nvidia.com>
References: <1386240249-30786-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <52A10D5C.3060002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2013 03:44 AM, Laxman Dewangan wrote:
> This patch series convert dts files of all Tegra's platforms to use the pinctron
> dt-binding macro for better readability.

I think this series looks fine now; I'll apply soon pending what happens
with the DMA/reset/ binding rework.

There are quite a few typos/spelling/capitalization mistakes in the
commit descriptions, but I'll fix them up when applying.
