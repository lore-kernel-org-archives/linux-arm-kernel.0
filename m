From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 26 Mar 2018 10:49:28 +0200
Subject: [PATCH v2] pinctrl: pinctrl-single: Fix pcs_request_gpio() when
 bits_per_mux != 0
In-Reply-To: <1519077427-30165-1-git-send-email-david@lechnology.com>
References: <1519077427-30165-1-git-send-email-david@lechnology.com>
Message-ID: <CACRpkdYNN9zSVTxMQQd=GhH44FtdR476bQdMagS6Y3it5j1FiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 10:57 PM, David Lechner <david@lechnology.com> wrote:

> This fixes pcs_request_gpio() in the pinctrl-single driver when
> bits_per_mux != 0. It appears this was overlooked when the multiple
> pins per register feature was added.
>
> Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure multiple pins of different modules")
> Signed-off-by: David Lechner <david@lechnology.com>

Patch applied for v4.17 with Tony's ACK.

Yours,
Linus Walleij
