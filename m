From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Dec 2011 00:43:32 +0100
Subject: [PATCH V2 0/1] dmaengine/amba-pl08x: Add support for s3c64xx DMAC
In-Reply-To: <1317189007-23033-1-git-send-email-alim.akhtar@samsung.com>
References: <1317189007-23033-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <CACRpkdZC8LOOLkWbrPbXN_nKaw-WvueusYDyrX48Q1Pcdwv3Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 7:50 AM, Alim Akhtar <alim.akhtar@samsung.com> wrote:

> This patch modifies the amba-pl08x driver for s3c64xx.
> The DMA controller of S3C64XX is a variant of PrimeCell pl080 DMAC.
> S3C64xx contents extra register to hold the TransferSize.

Alim what is happening with this patch series?

I was really happy with the rate of progress we had and Viresh & I
have given most feedback needed to complete this I think.

Yours,
Linus Walleij
