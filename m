From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 22 Jun 2017 15:39:20 -0700
Subject: [GIT PULL 1/7] Broadcom soc changes for 4.13 (v2)
In-Reply-To: <20170613201044.9808-1-f.fainelli@gmail.com>
References: <20170613201044.9808-1-f.fainelli@gmail.com>
Message-ID: <e426718d-bac6-adcb-4aed-b56d77e77757@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2017 01:10 PM, Florian Fainelli wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.13/soc
> 
> for you to fetch changes up to 27d9fa06c122b135ad7552fa3138c3b47e5776c5:
> 
>   ARM: BCM: Enable thermal support for NSP SoCs (2017-05-19 11:30:25 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoCs (non Device Tree) changes:
> 
> - Jon updates the Kconfig entry for Northstar Plus to have THERMAL and THERMAL_OF
>   selected in order to get the NS/NSP thermal driver dependencies to be satistfied
> 
> ----------------------------------------------------------------

I did not see an email indicating this was merged, but the changes seem
to be here:

https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/commit/?h=next/soc&id=27d9fa06c122b135ad7552fa3138c3b47e5776c5

-- 
Florian
