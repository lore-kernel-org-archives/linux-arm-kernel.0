From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 14 Dec 2011 16:26:14 +0800
Subject: [PATCH v2] SPI: add CSR SiRFprimaII SPI controller driver
In-Reply-To: <1323849835-17995-1-git-send-email-Barry.Song@csr.com>
References: <1323849835-17995-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CAGsJ_4zDFWH2iVqV4_payr2TEYG5NhAuz2EbpBJn2Uq0uuJOSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/12/14 Barry Song <Barry.Song@csr.com>:
> From: Zhiwu Song <zhiwu.song@csr.com>
>
> CSR SiRFprimaII has two SPIs (SPI0 and SPI1). Features:
> * Master and slave modes
> * 8-/12-/16-/32-bit data unit
> * 256 bytes receive data FIFO and 256 bytes transmit data FIFO
> * Multi-unit frame
> * Configurable SPI_EN (chip select pin) active state
> * Configurable SPI_CLK polarity
> * Configurable SPI_CLK phase
> * Configurable MSB/LSB first
>
> Signed-off-by: Zhiwu Song <zhiwu.song@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
> ?-v2:
> ?fix bundle of minor issues Wolfram Sang pointed out;
> ?use Wolfram Sang's new devm_request_mem_region api, refer to:
> ?https://lkml.org/lkml/2011/10/25/226

sorry. due to some misoperations and typos in it, pls ignore it and read
"[PATCH v2 RESEND] SPI: add CSR SiRFprimaII SPI controller driver"  instead.

-barry
