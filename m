From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 30 Mar 2018 15:33:30 +0800
Subject: [PATCH 0/6] spi: Add support for DMA transfers in sun6i SPI driver
In-Reply-To: <20180330072243.19368-1-ssuloev@orpaltech.com>
References: <20180330072243.19368-1-ssuloev@orpaltech.com>
Message-ID: <CAGb2v642R=zNmLLz2t4B=xB9wu9yefRs6WG_5fPkuD1-9vLTQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2018 at 3:22 PM, Sergey Suloev <ssuloev@orpaltech.com> wrote:
> The following patchset provides corrections for PIO-mode
> and support for DMA transfers in sun6i SPI driver.

Is this the same series you sent 12 hours ago? What's different?
Please version your patch series and provide a changelog.

ChenYu

> Sergey Suloev (6):
>   spi: sun6i: coding style/readability improvements
>   spi: sun6i: handle chip select polarity flag
>   spi: sun6i: restrict transfer length in PIO-mode
>   spi: sun6i: use completion provided by SPI core
>   spi: sun6i: introduce register set/unset helpers
>   spi: sun6i: add DMA transfers support
>
>  drivers/spi/spi-sun6i.c | 501 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 378 insertions(+), 123 deletions(-)
>
> --
> 2.16.2
>
