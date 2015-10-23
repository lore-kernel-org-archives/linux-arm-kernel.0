From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Oct 2015 10:14:37 +0200
Subject: [PATCH v2 2/2] pinctrl: sunxi: Add irq pinmuxing to sun6i "r"
 pincontroller
In-Reply-To: <1444981572-17235-3-git-send-email-hdegoede@redhat.com>
References: <1444981572-17235-1-git-send-email-hdegoede@redhat.com>
 <1444981572-17235-3-git-send-email-hdegoede@redhat.com>
Message-ID: <CACRpkda2m06DPn1em2hnNx3-inbYt128geQHuTG3GuHypL-rfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 9:46 AM, Hans de Goede <hdegoede@redhat.com> wrote:

> Add pinmuxing for external interrupt functionality through the
> sun6i "r" pincontroller.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Fix compile error introduced by last minute changes before sending out
>  the patch (note to self: always do a recompile in such a case)

Patch applied with Chen-Yu's and Maxime's ACKs.

Yours,
Linus Walleij
