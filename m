From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 15:13:02 +0200
Subject: [PATCH 07/10] ARM: ux500: Add an auxdata entry for MUSB for
 clock-name look-up
In-Reply-To: <1366729394-11406-8-git-send-email-lee.jones@linaro.org>
References: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
 <1366729394-11406-8-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYK0W4wLGSK9akY7Ji4j8EUW=XwO8GCHpkXuLbP-aZW1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 5:03 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The recently DT:ed MUSB driver will require clock-name by device-name
> look-up capability, until common clk has is properly supported by the
> ux500 platform.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
