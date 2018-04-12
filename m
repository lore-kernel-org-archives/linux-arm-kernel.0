From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Apr 2018 10:14:38 +0200
Subject: [PATCHv2] pinctrl: samsung: add pin_dbg_show callback for debugfs
In-Reply-To: <20180327135801.9556-1-parkch98@gmail.com>
References: <20180327135801.9556-1-parkch98@gmail.com>
Message-ID: <CACRpkdaudDZ4H_t-bWzuFOLU6bxCrV=DOLisO1Jw=ufg9e2Bkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 3:58 PM, Chanho Park <parkch98@gmail.com> wrote:

> This patch adds a samsung_pin_dbg_show function to implement the
> pin_dbg_show callback function which can be used to show pin
> confuration values. Basically, it can show pin setting values by
> accessing the "pins" node like below:
>
> $ cat pins
> pin 0 (gpy7-0)  CON(0x0) DAT(0x1) PUD(0x1) DRV(0x0) CON_PDN(0x0) PUD_PDN(0x0)
>
> Signed-off-by: Chanho Park <parkch98@gmail.com>
> ---
> Changes from v1:
> - use samsung_pinconf_get instead of samsung_pinconf_rw
> - use "static const char * const" type declaration of reg_names
> - skip condition change

Patch applied directly to my tree for v4.18 with the
ACKs!

Yours,
Linus Walleij
