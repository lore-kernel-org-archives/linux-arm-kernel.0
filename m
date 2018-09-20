From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Sep 2018 15:00:31 -0700
Subject: [PATCH] ARM: dts: ste: Fix SPI controller node names
In-Reply-To: <20180913181245.25484-10-robh@kernel.org>
References: <20180913181245.25484-10-robh@kernel.org>
Message-ID: <CACRpkdY+oza3sFbp_vOAS2w-9DkhaywzX4kaz-7sWCpkXaNbpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 11:12 AM Rob Herring <robh@kernel.org> wrote:

> SPI controller nodes should be named 'spi' rather than 'ssp'. Fixing the
> name enables dtc SPI bus checks.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to the ux500 tree, thanks!

Yours,
Linus Walleij
