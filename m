From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Oct 2015 10:12:33 +0200
Subject: [PATCH v2 1/2] pinctrl: sunxi: Fix irq_of_xlate for the r_pio
 pinctrl block
In-Reply-To: <1444981572-17235-2-git-send-email-hdegoede@redhat.com>
References: <1444981572-17235-1-git-send-email-hdegoede@redhat.com>
 <1444981572-17235-2-git-send-email-hdegoede@redhat.com>
Message-ID: <CACRpkdZjYjHzQEJuHzLeWc323f60+i=Pc98BzT66aw9nTXan8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 9:46 AM, Hans de Goede <hdegoede@redhat.com> wrote:

> The r_pio gpio / pin controller has a pin_base of non 0, we need to
> adjust for this before calling sunxi_pinctrl_desc_find_function_by_pin.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch applied with Chen-Yu's and Maxime's ACKs.

Yours,
Linus Walleij
