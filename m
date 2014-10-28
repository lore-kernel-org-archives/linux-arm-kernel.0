From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Oct 2014 17:17:54 +0100
Subject: [PATCH] pinctrl: at91: use own header
In-Reply-To: <1413539380-7046-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1413539380-7046-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <CACRpkdbkVXCtaVY1S24bZ-q8vam729p0seGvvpKOL-AQQMywTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 17, 2014 at 11:49 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

> Copy the mach/at91_pio.h header locally and use it for pinctrl-at91.c. This
> allows to remove the dependency on mach/at91_pio.h to be able to move at91 to
> multiplatform.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Patch applied to the pinctrl tree with Nicolas' ACK.

Yours,
Linus Walleij
