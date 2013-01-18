From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 18 Jan 2013 09:44:38 -0700
Subject: [PATCH] ARM: tegra: DTS: whistler: enable keyboard
In-Reply-To: <1358488723-23184-1-git-send-email-ldewangan@nvidia.com>
References: <1358488723-23184-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <50F97BF6.6020705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2013 10:58 PM, Laxman Dewangan wrote:
> Enable tegra based keyboard controller and populate the key mapping
> for whistler.
> 
> With this patch, HOME, BACK, POWER and MENU keys will work.
> Still other keys which are in ROW3 and ROW4 will not work as it
> conflicts with KBC pins on SDIO2 pinmux.

Thanks, applied to Tegra's for-3.9/dt branch.
