From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 30 Jul 2013 17:49:15 +0800
Subject: [PATCH 0/8] ARM: tegra: support LP1 suspend mode
In-Reply-To: <2389689.JgQlW00RdN@ax5200p>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <2389689.JgQlW00RdN@ax5200p>
Message-ID: <1375177755.1239.19.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2013-07-28 at 00:12 +0800, Marc Dietrich wrote:
> On Friday 26 July 2013 17:15:02 Joseph Lo wrote:
> > This series adds the support of LP1 suspend mode for Tegra.
> > 
> > Verified on Seaboard, Cardhu and Dalmore.
> 
> tested on AC100 and worked fine, except
> 
[unbalanced wake_enable/disable of rtc-6586x]
> 
> and sdcard being offline after resume (fixed by CONFIG_MMC_UNSAFE_RESUME=y). 
> Anyway, thanks for your great work!
> 
> Tested-By: Marc Dietrich <marvin24@gmx.de>
> 

Marc,

Thanks for your testing.
