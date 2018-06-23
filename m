From: olof@lixom.net (Olof Johansson)
Date: Sat, 23 Jun 2018 10:17:58 -0700
Subject: i.MX fixes for 4.18
In-Reply-To: <20180619081405.GF16091@dragon>
References: <20180619081405.GF16091@dragon>
Message-ID: <CAOesGMh=dihG2JpffcDwPWTJnB4DTOVDvv+nJ5tNNkcnkqpRCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 1:14 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.18
>
> for you to fetch changes up to 1bcfe0564044be578841744faea1c2f46adc8178:
>
>   ARM: dts: imx6sx: fix irq for pcie bridge (2018-06-19 14:39:36 +0800)
>
> ----------------------------------------------------------------
> i.MX fixes for 4.18:
>  - Fix i.MX6SX PCIe MSI interrupt number, so that MSI IRQs can be
>    properly propagated to the upstream interrupt controller.
>  - Fix GPCv2 MIPI/PCIe/USB_HSIC's PGC offset.  The values in Reference
>    Manual are incorrect.
>  - Correct SDMA setting for i.MX6Q SPI5 device to fix the issue, that
>    the SPI controller RX FIFO was not empty after a DMA transfer, and
>    the driver gets stuck in the next PIO transfer when reading one word
>    more than expected.

Merged, thanks!


-Olof
