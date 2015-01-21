From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Jan 2015 10:48:54 +0100
Subject: [PATCH v3 1/3] pinctrl: at91: allow to have disabled gpio bank
In-Reply-To: <1421422267-2934-2-git-send-email-ludovic.desroches@atmel.com>
References: <1421422267-2934-1-git-send-email-ludovic.desroches@atmel.com>
 <1421422267-2934-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <CACRpkdZg4hXF6f8o_OkRLRUfC_XqwUXLH4Yx+0p5XJSPya7HDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 4:31 PM, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:

> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>
> Today we expect that all the bank are enabled, and count the number of banks
> used by the pinctrl based on it instead of using the last bank id enabled.
>
> So switch to it, set the chained IRQ at runtime based on enabled banks
> and wait only the number of enabled gpio controllers at probe time.
>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Cc: <stable@vger.kernel.org> # 3.18

Patch applied for fixes with Nicolas' ACK.

Yours,
Linus Walleij
