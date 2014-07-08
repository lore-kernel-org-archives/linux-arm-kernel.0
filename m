From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Jul 2014 10:57:47 +0200
Subject: [PATCH 2/6] pinctrl: samsung: Handle GPIO request and free using
 pinctrl helpers
In-Reply-To: <1404315664-3174-3-git-send-email-t.figa@samsung.com>
References: <1404315664-3174-1-git-send-email-t.figa@samsung.com>
 <1404315664-3174-3-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdbytxN_+zwCDzo6zf8M-6aQm2fHSPjwA9oH6u8cN2hnaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 2, 2014 at 5:41 PM, Tomasz Figa <t.figa@samsung.com> wrote:

> This patch adds .request() and .free() operations to gpio_chip of
> pinctrl-samsung driver, which call pinctrl request and free helpers to
> request and free pinctrl pin along with GPIO pin.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>

Patch applied.

Yours,
Linus Walleij
