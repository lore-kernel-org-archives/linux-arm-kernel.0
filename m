From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Jan 2015 10:32:32 +0100
Subject: [PATCH] pinctrl: zynq: Fix usb0 pins
In-Reply-To: <1422290895-4046-1-git-send-email-afaerber@suse.de>
References: <1422290895-4046-1-git-send-email-afaerber@suse.de>
Message-ID: <CACRpkdYWoK2GJQGL3Krk4b5eUeo68tbKb=EYTMq0J+hbUkzdTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 5:48 PM, Andreas F?rber <afaerber@suse.de> wrote:

> Fix usb0 pin 19 -> 29 (matching ethernet1 pins and manual).
> Pin 19 is used for ethernet0 on the Parallella board.
>
> Fixes: add958cee967 ("pinctrl: Add driver for Zynq")
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

Patch applied with S?ren's ACK.

Yours,
Linus Walleij
