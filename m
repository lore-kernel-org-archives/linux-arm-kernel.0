From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 17:18:41 -0800
Subject: [GIT PULL 5/5] omap defconfig changes for v4.11 merge window
In-Reply-To: <58879776.0ada620a.ff7f0.43b9SMTPIN_ADDED_BROKEN@mx.google.com>
References: <pull-1485274191-192300>
 <58879776.0ada620a.ff7f0.43b9SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20170130011841.GZ3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 10:05:18AM -0800, Tony Lindgren wrote:
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.11/defconfig-signed
> 
> for you to fetch changes up to ac57feb25833a6f3832a436d28808ffc16c672b3:
> 
>   ARM: omap2plus_defconfig: Enable support for RTC M41T80 (2017-01-24 07:04:11 -0800)
> 
> ----------------------------------------------------------------
> Few omap2plus_defconfig changes for v4.11 merge window:
> 
> - Switch to use LIS3LV02DL IIO driver instead of the
>   LIS3LC02D misc driver
> 
> - Set CONFIG_SERIAL_8250_RUNTIME_UARTS=6 to avoid runtime
>   warnings on omap5 and dra7
> 
> - Enable ksz9021 phy and m41t80 rtc as they are used at
>   least on phyCORE-AM335x

Merged, thanks.


-Olof
