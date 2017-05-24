From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 24 May 2017 15:19:24 -0700
Subject: [PATCH 1/2] ARM: dts: add GSBI8 defines to the MSM8660 family
In-Reply-To: <20170515075012.3696-1-linus.walleij@linaro.org>
References: <20170515075012.3696-1-linus.walleij@linaro.org>
Message-ID: <20170524221924.GB12920@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 15 May 00:50 PDT 2017, Linus Walleij wrote:

> This defines the memory location and interrupt used by the GSBI8
> I2C adapter on the MSM8660 SoCs. We add it as "disabled" by
> default so that boards using this I2C can enable it.
> 

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
