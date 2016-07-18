From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 18 Jul 2016 22:50:37 +0200
Subject: [PATCH] arm64: dts: rockchip: add spiX aliases for rk3399
In-Reply-To: <1468545873-134339-1-git-send-email-briannorris@chromium.org>
References: <1468545873-134339-1-git-send-email-briannorris@chromium.org>
Message-ID: <2463583.1KcLgghiy0@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 14. Juli 2016, 18:24:33 schrieb Brian Norris:
> It's nicer to see this:
> 
>     # ls -l /sys/bus/spi/devices/
>     total 0
>     lrwxrwxrwx 1 root root 0 Dec 31  1969 spi0.0 ->
> ../../../devices/platform/ff1c0000.spi/spi_master/spi0/spi0.0 lrwxrwxrwx 1
> root root 0 Dec 31  1969 spi1.0 ->
> ../../../devices/platform/ff1d0000.spi/spi_master/spi1/spi1.0 lrwxrwxrwx 1
> root root 0 Dec 31  1969 spi2.0 ->
> ../../../devices/platform/ff1e0000.spi/spi_master/spi2/spi2.0 lrwxrwxrwx 1
> root root 0 Dec 31  1969 spi5.0 ->
> ../../../devices/platform/ff200000.spi/spi_master/spi5/spi5.0
> 
> than this:
> 
>     # ls -l /sys/bus/spi/devices/
>     total 0
>     lrwxrwxrwx 1 root root 0 Dec 31  1969 spi32763.0 ->
> ../../../devices/platform/ff200000.spi/spi_master/spi32763/spi32763.0
> lrwxrwxrwx 1 root root 0 Dec 31  1969 spi32764.0 ->
> ../../../devices/platform/ff1e0000.spi/spi_master/spi32764/spi32764.0
> lrwxrwxrwx 1 root root 0 Dec 31  1969 spi32765.0 ->
> ../../../devices/platform/ff1d0000.spi/spi_master/spi32765/spi32765.0
> lrwxrwxrwx 1 root root 0 Dec 31  1969 spi32766.0 ->
> ../../../devices/platform/ff1c0000.spi/spi_master/spi32766/spi32766.0
> 
> With the latter, it's much clearer which bus devices are on.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

applied for 4.9

Thanks
Heiko
