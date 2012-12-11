From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Dec 2012 10:17:49 +0100
Subject: [PATCH 07/12] ARM: ux500: Specify the ux5x0 MMCI regulator's
 on/off GPIO as high-enable
In-Reply-To: <1355129761-8088-8-git-send-email-lee.jones@linaro.org>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
 <1355129761-8088-8-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaDoLnyn4DHoEnha7zxxYA7v7nyte1CeeRyp87O6EE3xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 9:55 AM, Lee Jones <lee.jones@linaro.org> wrote:

> If not specified, the GPIO control bit is inverted by default i.e.
> low-enable and high-disable. This is not the case with the MMCI
> regulator, hence it will turn on during a disable and off when
> regulator_enable() is invoked.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
