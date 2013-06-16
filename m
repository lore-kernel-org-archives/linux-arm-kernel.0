From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 16 Jun 2013 12:31:42 +0200
Subject: [PATCH 4/5] pinctrl: dynamically alloc temp array when parsing dt
 pinconf options
In-Reply-To: <201306141743.55811.heiko@sntech.de>
References: <201306141741.46077.heiko@sntech.de>
 <201306141743.55811.heiko@sntech.de>
Message-ID: <CACRpkdZaSng72gpULBtpPKvYw+7jp2rePFv==xGQrWHqBsHrFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 5:43 PM, Heiko St?bner <heiko@sntech.de> wrote:

> Allocating the temorary array in pinconf_generic_parse_dt_config on stack
> might cause problems later on, when the number of options grows over time.
> Therefore also allocate this array dynamically to be on the safe side.
>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Patch applied.

Yours,
Linus Walleij
