From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 25 Sep 2017 15:41:23 +0100
Subject: Tegra baseline test results for v4.14-rc2
In-Reply-To: <dbdcc12f-b1fa-4160-1b96-32270a528eed@nvidia.com>
References: <dbdcc12f-b1fa-4160-1b96-32270a528eed@nvidia.com>
Message-ID: <403cde74-abd6-1ae7-b230-3a87054923ea@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry,

On 25/09/17 15:29, Jon Hunter wrote:
> Tegra baseline test results for v4.14-rc2
> 
> 
> Here are some basic Tegra test results for Linux v4.14-rc2.
> Logs and other details at:
> 
>     https://nvtb.github.io//linux/test_v4.14-rc2/20170924170104/
> 
> 
> Test summary
> ------------
> 
> Build: zImage:
>     FAIL: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Have you sent your DRM fixes yet? Seems the include path in the Tegra
DRM is still breaking the build.

Cheers
Jon

-- 
nvpublic
