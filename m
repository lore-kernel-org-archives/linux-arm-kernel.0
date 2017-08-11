From: tj@kernel.org (Tejun Heo)
Date: Fri, 11 Aug 2017 10:32:37 -0700
Subject: [PATCH 2/2] ata: sata_gemini: Introduce explicit IDE pin control
In-Reply-To: <20170808190714.11623-1-linus.walleij@linaro.org>
References: <20170808190714.11623-1-linus.walleij@linaro.org>
Message-ID: <20170811173236.GC3005423@devbig577.frc2.facebook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08, 2017 at 09:07:14PM +0200, Linus Walleij wrote:
> The IDE pins are managed by the pin controller, if we want to
> use these, we need to ask the pin controller to explicitly enable
> them as by default, these pins are used for other business and
> most users just rely on the SATA bridge.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied to libata/for-4.14.

Thanks.

-- 
tejun
