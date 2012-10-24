From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Oct 2012 19:47:41 +0200
Subject: [PATCH 4/6] ARM: ux500: Specify AMBA Primecell IDs for Nomadik
 I2C in DT
In-Reply-To: <1351089926-32161-5-git-send-email-lee.jones@linaro.org>
References: <1351089926-32161-1-git-send-email-lee.jones@linaro.org>
 <1351089926-32161-5-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYxVPxqpYGX2_O65ykipT9zFP5Us0O-DKPK1ePnoVixTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 4:45 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Now the Nomadik I2C driver has been converted to an AMBA one, we
> are required to provide the Primecell IDs via platform code. When
> booting with DT enabled these have to be specified in the device
> nodes. We do that here.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I suspect this should go to stable as well.

Yours,
Linus Walleij
