From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Sep 2014 17:00:53 +0200
Subject: [PATCH] pinctrl: at91: disable Pull-Down or Pull-Up property
 before enabling Pull-Up or Pull-Down.
In-Reply-To: <1410446415-29410-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1410446415-29410-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <CACRpkdZi0XMXN6PG2Q4sSkVtV1ogpK0-O_ZTuccB4NduR4qZ2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 4:40 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

> From: Wenyou Yang <wenyou.yang@atmel.com>
>
> Because the pin's Pull-Up and Pull-Down property is mutually exclusive.
>
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Patch applied with Nicolas' ACK.

Yours,
Linus Walleij
