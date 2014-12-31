From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 31 Dec 2014 09:18:02 +0100
Subject: [PATCH v4 4/4] Documentation: dt: gpio: Add gpio-number-forward
 property in snps gpio binding doc
In-Reply-To: <1417750722-14027-5-git-send-email-wangzhou.bry@gmail.com>
References: <1417750722-14027-1-git-send-email-wangzhou.bry@gmail.com>
 <1417750722-14027-5-git-send-email-wangzhou.bry@gmail.com>
Message-ID: <CACRpkdaBVN46BMO3Q5mN8OncghG3VH2=zv66EyWJEK1rwx3P6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 5, 2014 at 4:38 AM, Zhou Wang <wangzhou.bry@gmail.com> wrote:

> This property is used to indicate gpiochip_find_base() to find GPIO
> base number in increasing order.
>
> Signed-off-by: Zhou Wang <wangzhou.bry@gmail.com>

NAK. GPIO numbers is a Linux-internal thing, not a OS independent
property.

Yours,
Linus Walleij
