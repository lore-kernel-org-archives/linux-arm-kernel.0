From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 18 Jun 2012 13:29:43 +0200
Subject: [PATCH 2/3] ARM: ux500: Add i2c configurations to the Device Tree
 for DB8500 based devices
In-Reply-To: <4FD8BAE4.4050606@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
 <4FD8BAE4.4050606@linaro.org>
Message-ID: <CACRpkda2pH1by2hajpP20CJgdg+mWFF=QaGbeNdY=c8iOVtLUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 6:08 PM, Lee Jones <lee.jones@linaro.org> wrote:

> + ? ? ? ? ? ? ? ? ? ? ? clock-frequency = <100000>;
> + ? ? ? ? ? ? ? ? ? ? ? stericsson,slsu = <0xe>;
> + ? ? ? ? ? ? ? ? ? ? ? stericsson,tft = <1>;
> + ? ? ? ? ? ? ? ? ? ? ? stericsson,rft = <8>;
> + ? ? ? ? ? ? ? ? ? ? ? stericsson,timeout = <200>;
> + ? ? ? ? ? ? ? ? ? ? ? stericsson,i2c_freq_mode_fast;

In the context of my patch to the board file, we conclude that the
clock-frequency should be set to 400000 instead.

Yours,
Linus Walleij
