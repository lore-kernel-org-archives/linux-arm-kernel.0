From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 18 Sep 2017 13:31:17 +0100
Subject: Tegra baseline test results for v4.14-rc1
In-Reply-To: <78b1e33f-cc9f-85c6-c7ae-3ecf0f1c2da4@nvidia.com>
References: <78b1e33f-cc9f-85c6-c7ae-3ecf0f1c2da4@nvidia.com>
Message-ID: <c79d5bcd-ad30-e93e-3e5e-01070b379fee@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 18/09/17 12:35, Jon Hunter wrote:
> Here are some basic Tegra test results for Linux v4.14-rc1.
> Logs and other details at:
> 
>     https://nvtb.github.io//linux/test_v4.14-rc1/20170916163103/
> 
> 
> Test summary
> ------------
> 
> Build: zImage:
>     FAIL: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Build failures are occurring in Tegra DRM driver and a fix is available
here [0]. With this fix in place we are seeing some failures in system
suspend for Tegra30/114/124 and this is being discussed here [1].

Cheers
Jon

[0]
https://cgit.freedesktop.org/tegra/linux/commit/?h=drm/tegra/for-next&id=65d5d30ccebd555de9ad8fd2b5dfc50291922337
[1] https://marc.info/?l=linux-tegra&m=150471582826806&w=2

-- 
nvpublic
