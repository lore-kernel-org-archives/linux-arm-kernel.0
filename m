From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Feb 2014 09:38:32 +0100
Subject: [PATCH 4/4] pinctrl-sunxi: Fix interrupt register offset
 calculation
In-Reply-To: <1392671984-29872-5-git-send-email-hdegoede@redhat.com>
References: <1392671984-29872-1-git-send-email-hdegoede@redhat.com>
 <1392671984-29872-5-git-send-email-hdegoede@redhat.com>
Message-ID: <CACRpkdZj+h0RkGK_a-iVTt6ZmmzkfXOU40rLEPaeszgUadZ_Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 10:19 PM, Hans de Goede <hdegoede@redhat.com> wrote:

> This fixing setting the interrupt type for eints >= 8.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
