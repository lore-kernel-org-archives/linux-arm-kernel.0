From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Apr 2015 14:58:11 -0700
Subject: [GIT PULL 2/5] Samsung defconfig udpates for v4.1
In-Reply-To: <551C35F6.1090602@kernel.org>
References: <551C35F6.1090602@kernel.org>
Message-ID: <20150403215811.GU23023@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 03:16:22AM +0900, Kukjin Kim wrote:
> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
> 
>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-defconfig
> 
> for you to fetch changes up to bb84296ae52da844c9cab81e0197152a69f2f841:
> 
>   ARM: exynos_defconfig: Enable HDMI support (2015-03-27 02:00:09 +0900)
> 
> ----------------------------------------------------------------
> Samsung defconfig updates for v4.1
> 
> - update exynos-defconfig
>   : enable HDMI, CPUidle, ChromeOS EC chardev driver
>     and thermal emulation, Marvell WiFi-Ex, CPUfreq,
>     and support for NFS rootfs
>   : remove EXYNOS_THERMAL_CORE define
>     and disable IOMMU support until support it

Merged, thanks.


-Olof
