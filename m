From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 10:42:46 +0200
Subject: [PATCH 26/39] ARM: ux500: Add an auxdata entry for MUSB for
 clock-name look-up
In-Reply-To: <1368611522-9984-27-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-27-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYzy-Nq5x=_tNweOTmTshkeswe0uk3c65bCOxFNCcYWZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> The recently DT:ed MUSB driver will require clock-name by device-name
> look-up capability, until common clk has is properly supported by the
> ux500 platform.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to my ux500-devicetree branch.

Yours,
Linus Walleij
