From: qca_vkondrat@qca.qualcomm.com (Vladimir Kondratiev)
Date: Thu, 2 Oct 2014 14:29:06 +0300
Subject: [PATCH] wil6210: remove obsolete msm platform code
In-Reply-To: <3995357.SmO1fZQuHn@wuerfel>
References: <3995357.SmO1fZQuHn@wuerfel>
Message-ID: <1572828.LhiMXjHRdV@lx-wigig-72>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 30, 2014 05:48:20 PM Arnd Bergmann wrote:
> The wil6210 driver has a glue layer for the Qualcomm MSM platform
> code, which apparently could never build and is unlikely to
> ever be able to in the future, as the MSM platform is being phased
> out in favor of the new QCOM platform, and the driver relies
> on out-of-tree infrastructure. Trying to build it currently
> results in this error:
> 
> drivers/net/wireless/ath/wil6210/wil_platform_msm.c:19:27: fatal error: linux/msm-bus.h: No such file or directory
> 
> Removing the driver fixes the build and makes it possible to
> build an allmodconfig kernel for MSM.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 

We are investigating this, looking for the appropriate solution.
Thanks for pointing to this.

Thanks, Vladimir
