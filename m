From: tj@kernel.org (Tejun Heo)
Date: Fri, 11 Aug 2017 10:32:58 -0700
Subject: [PATCH 1/2] ata: sata_gemini: Retire custom pin control
In-Reply-To: <20170808190704.11574-1-linus.walleij@linaro.org>
References: <20170808190704.11574-1-linus.walleij@linaro.org>
Message-ID: <20170811173257.GD3005423@devbig577.frc2.facebook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08, 2017 at 09:07:04PM +0200, Linus Walleij wrote:
> I added a proper pin control driver for the Gemini SoC, so retire
> this custom code and rely on the pin controller to set up the pads.
> 
> The "IOMUX" which is routing signals between the ATA and SATA
> bridge inside of the chip is not about pin control and remains in
> place.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied to libata/for-4.14.

Thanks.

-- 
tejun
