From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Feb 2014 09:31:52 +0100
Subject: [PATCH 1/4] pinctrl-sunxi: Fix sun5i-a13 port F multiplexing
In-Reply-To: <1392671984-29872-2-git-send-email-hdegoede@redhat.com>
References: <1392671984-29872-1-git-send-email-hdegoede@redhat.com>
 <1392671984-29872-2-git-send-email-hdegoede@redhat.com>
Message-ID: <CACRpkdbVC6cGH-5pvGEyH7FfFryEbobe3pXBb=qra-z=mnQcoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 10:19 PM, Hans de Goede <hdegoede@redhat.com> wrote:

> The correct value for selecting the mmc0 function on port F pins is 2 not 4,
> as per the data-sheet:
> http://dl.linux-sunxi.org/A13/A13%20Datasheet%20-%20v1.12%20%282012-03-29%29.pdf
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
