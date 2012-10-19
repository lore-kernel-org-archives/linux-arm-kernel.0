From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Oct 2012 13:15:59 +0200
Subject: [PATCH] GPIO: vt8500: Add extended gpio bank for WM8505/WM8650
In-Reply-To: <1350497893-25106-1-git-send-email-linux@prisktech.co.nz>
References: <1350497893-25106-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <CACRpkdbwmqaR2D9R9dnrP2evBCpGC-jJ+OPzsaU8ELVfofM+bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2012 at 8:18 PM, Tony Prisk <linux@prisktech.co.nz> wrote:

> These SoC's have an extended bank of GPIO's seperate to the main
> GPIO block. This patch adds the additional 5 GPIO's located in this
> block which control I2C and PWMOUT.
>
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

Applied.

Thanks!
Linus Walleij
