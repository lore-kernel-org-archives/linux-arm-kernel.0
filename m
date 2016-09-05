From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 5 Sep 2016 20:38:50 +0100
Subject: Tegra baseline test results for v4.8-rc4
In-Reply-To: <1f415bf9-3f21-8516-e70c-e3bf65d7ea96@nvidia.com>
References: <1f415bf9-3f21-8516-e70c-e3bf65d7ea96@nvidia.com>
Message-ID: <490eafaf-04f6-79e1-6b8d-ffe8e523e083@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 05/09/16 20:37, Jon Hunter wrote:
> Here are some basic Tegra test results for Linux v4.8-rc4.
> Logs and other details at:
> 
>     https://nvtb.github.io//linux/test_v4.8-rc4/20160828153103/
> 
> 
> Test summary
> ------------
> 
> Build: zImage:
>     FAIL: ( 1/ 2): multi_v7_defconfig

This build break has been fixed by the following commit:

https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=timers/urgent&id=98744b408c757901df57fa50cbd5826245dc3a1f

Cheers
Jon

-- 
nvpublic
