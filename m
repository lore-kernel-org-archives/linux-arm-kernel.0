From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 May 2018 10:30:48 +0200
Subject: [PATCH v2] pinctrl: pinctrl-single: Add functions to save and
 restore pinctrl context
In-Reply-To: <1526532021-16387-1-git-send-email-j-keerthy@ti.com>
References: <1526532021-16387-1-git-send-email-j-keerthy@ti.com>
Message-ID: <CACRpkdbh6kpRaGaY7aux5L=JcgQi-pOtRxp9wsrYvrZ7ZSa3pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 6:40 AM, Keerthy <j-keerthy@ti.com> wrote:

> This adds a pair of context save/restore functions to save/restore the
> state of a set of pinctrl registers. The context is lost during rtc only
> suspend with ddr in self-refresh on am43xx. Currently the save/restore
> is being done unconditionally. This will be optimized later with a
> pdata-quirk function which will allow is to save/restore only when doing
> the rtc only mode with ddr in self refresh.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>
> Changes in v2:

Patch applied with Tony's ACK.

Yours,
Linus Walleij
