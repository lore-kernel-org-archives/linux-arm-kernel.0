From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Sat, 4 Apr 2015 08:47:31 +0200
Subject: [GIT PULL 2/5] Samsung defconfig udpates for v4.1
In-Reply-To: <551C35F6.1090602@kernel.org>
References: <551C35F6.1090602@kernel.org>
Message-ID: <CABxcv=kHPaJE4WGUHsgBPnFpT4aYqiodHVnTn+AccUhu3Te-Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

On Wed, Apr 1, 2015 at 8:16 PM, Kukjin Kim <kgene@kernel.org> wrote:
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
>
> ----------------------------------------------------------------
> Javier Martinez Canillas (5):
>       ARM: exynos_defconfig: Disable IOMMU support

As I mentioned before, this also is needed for 4.0-rc to have display
working on at least Exynos5420 Peach Pit and Exynos5800 Peach Pi
Chromebooks but I saw that it is not included in your "Samsung 2nd
fixes for v4.0" git pull [0].

Maybe it can be sent directly to arm at kernel.org?

Best regards,
Javier

[0]: http://www.spinics.net/lists/arm-kernel/msg410078.html
