From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Feb 2014 09:33:40 +0100
Subject: [PATCH 2/4] pinctrl-sunxi: Fix hang on gpio irq
In-Reply-To: <1392671984-29872-3-git-send-email-hdegoede@redhat.com>
References: <1392671984-29872-1-git-send-email-hdegoede@redhat.com>
 <1392671984-29872-3-git-send-email-hdegoede@redhat.com>
Message-ID: <CACRpkdae0LibEn8B1opXL6XGUosgbopkRjPFM-pfzEfU0BT_xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 10:19 PM, Hans de Goede <hdegoede@redhat.com> wrote:

> Our irq handler was missing chained_irq_enter / exit calls, causing a
> hard hang as soon as a gpio irq happened.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I have already applied the identical patch from
Chen-Yu Tsai for fixes so dropping this.

Yours,
Linus Walleij
