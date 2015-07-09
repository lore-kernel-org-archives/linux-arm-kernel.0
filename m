From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 9 Jul 2015 16:58:24 +0200
Subject: [PATCH 1/2] ARM: ep93xx: vision_ep9307: enable DMA for SPI
In-Reply-To: <1434473567-5258-2-git-send-email-hsweeten@visionengravers.com>
References: <1434473567-5258-1-git-send-email-hsweeten@visionengravers.com>
 <1434473567-5258-2-git-send-email-hsweeten@visionengravers.com>
Message-ID: <CACRpkdbS0hpiKxeqaQV_VegT8V2MPyddRtJdXPM5RYKgYF8jCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 6:52 PM, H Hartley Sweeten
<hsweeten@visionengravers.com> wrote:

> Enable the 'use_dma' flag in the SPI platform data to improve the speed
> of the mmc_spi driver.
>
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

I've signed this off and queued for my pull request to ARM SoC.
Also cooking a similar patch for my simone card.

Yours,
Linus Walleij
