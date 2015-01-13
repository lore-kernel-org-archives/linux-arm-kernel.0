From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Jan 2015 15:31:37 +0100
Subject: [PATCH v2 02/13] pinctrl: sun6i: Add A31s pinctrl support
In-Reply-To: <1418836704-15689-3-git-send-email-hdegoede@redhat.com>
References: <1418836704-15689-1-git-send-email-hdegoede@redhat.com>
 <1418836704-15689-3-git-send-email-hdegoede@redhat.com>
Message-ID: <CACRpkdb8wzjAc+14tK=d7coi6H8gts7TrvwELqo0e0RHLsB6Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 6:18 PM, Hans de Goede <hdegoede@redhat.com> wrote:

> The A31s is a stripped down version of the A31, as such it is missing some
> pins and some functions on some pins.
>
> The new pinctrl-sun6i-a31s.c this commit adds is a copy of pinctrl-sun6i-a31s.c
> with the missing pins and functions removed.
>
> Note there is no a31s specific version of pinctrl-sun6i-a31-r.c, as the
> prcm pins are identical between the A31 and the A31s.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Sync i2c3 muxing with v2 of "pinctrl: sun6i: Add some missing functions"
> -Add myself to the copyright header

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
