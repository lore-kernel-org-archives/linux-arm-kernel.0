From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Dec 2012 20:12:08 +0100
Subject: [PATCH 4/4] net/smsc911x: Provide common clock functionality
In-Reply-To: <1355937587-31730-4-git-send-email-lee.jones@linaro.org>
References: <1355937587-31730-1-git-send-email-lee.jones@linaro.org>
 <1355937587-31730-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkda79O_b3Z8g7Sy7vMtW9neZU4x-Z=iEQgjqu4X5tFKyhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 6:19 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Some platforms provide clocks which require enabling before the
> SMSC911x chip will power on. This patch uses the new common clk
> framework to do just that. If no clock is provided, it will just
> be ignored and the driver will continue to assume that no clock
> is required for the chip to run successfully.
>
> Cc: Steve Glendinning <steve.glendinning@shawell.net>
> Cc: netdev at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Seems to me like it'll do the trick.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
