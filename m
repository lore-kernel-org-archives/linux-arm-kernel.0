From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 31 Oct 2018 12:20:00 +0100
Subject: [PATCH v1 00/14] Rockchip SPI cleanup and use interrupts
In-Reply-To: <20181031105711.19575-1-esmil@mailme.dk>
References: <20181031105711.19575-1-esmil@mailme.dk>
Message-ID: <4443653.p1DpZLIVTj@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 31. Oktober 2018, 11:56:57 CET schrieb Emil Renner Berthing:
> Emil Renner Berthing (14):
>   spi: rockchip: make spi_enable_chip take bool
>   spi: rockchip: use designated init for dma config
>   spi: rockchip: always use SPI mode
>   spi: rockchip: use atomic_t state
>   spi: rockchip: disable spi on error
>   spi: rockchip: read transfer info directly
>   spi: rockchip: don't store dma channels twice
>   spi: rockchip: remove master pointer from dev data
>   spi: rockchip: simplify use_dma logic
>   spi: rockchip: set min/max speed
>   spi: rockchip: precompute rx sample delay
>   spi: rockchip: use irq rather than polling
>   spi: rockchip: support 4bit words
>   spi: rockchip: support lsb-first mode

The series, on rk3288 with cros-ec and spi-flash, rk3328 with a spi-flash, 
rk3399 with cros-ec and spi-flash:

Tested-by: Heiko Stuebner <heiko@sntech.de>
