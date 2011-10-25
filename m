From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Oct 2011 10:39:35 +0200
Subject: [RFC] ARM: at91: gpio add mux check
In-Reply-To: <1319462000-32642-1-git-send-email-plagnioj@jcrosoft.com>
References: <1319462000-32642-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <CACRpkdbDLSy+87Obw2LnuBmrUn_v6WSFjN5PuD_UXSTRq66aWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2011 at 3:13 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:

> Hi,
>
> ? ? ? ?one of the the issue is what happened it the bootloader miss
> ? ? ? ?configured a pin a periph A or B?
>
> ? ? ? ?do we need to keep the tracking of it in the pinmux?

Is there an AT91 pinmux driver? If yes, I guess it's something custom and I
have only looked briefly at these. Generally I would recommend modeling
any muxing using the pinctrl subsystem but if and only if Torvalds decide to
pull it in.

Yours.
Linus Walleij
