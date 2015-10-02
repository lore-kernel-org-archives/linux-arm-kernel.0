From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Oct 2015 03:33:04 -0700
Subject: [PATCH] pinctrl: sun5i: Fix a10s pwm1 pinctrl mapping
In-Reply-To: <1442699804-15526-1-git-send-email-hdegoede@redhat.com>
References: <1442699804-15526-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CACRpkdaJvdTS+As54eBwcHTjwc-NAZ29cFVpOpDJzPG2RveVqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 19, 2015 at 2:56 PM, Hans de Goede <hdegoede@redhat.com> wrote:

> The comment for PG14 mux setting 3 already correctly states that this
> muxes PG13 to pwm1, but the text ascociated with it said uart3, fix this.
>
> Note that we use "pwm" rather then "pwm1" to be consistent with pwm0
> where the mux setting is also simply called "pwm" and to be consistent
> with sun4i/sun7i which do the same.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch applied for fixes with Maxime's ACK.

Yours,
Linus Walleij
