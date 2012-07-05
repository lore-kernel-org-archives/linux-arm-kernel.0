From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Jul 2012 15:24:50 +0200
Subject: [PATCH] gpio: samsung: add flags specifier to device-tree binding
In-Reply-To: <1340684301-16836-1-git-send-email-olof@lixom.net>
References: <1340684301-16836-1-git-send-email-olof@lixom.net>
Message-ID: <CACRpkdYTgMi=O76ZmkVxkXCkc4WnY9cu86oDvU_Oq2sZQhkCBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 6:18 AM, Olof Johansson <olof@lixom.net> wrote:

> This adds a flags field to the gpio specifier for Samsung. I didn't
> want to add yet another field in the already quite long specifier, so
> I decided to compress it together with the Pull Up/Down settings instead.
>
> This is needed to, for example, have a gpio-keys input that is active low.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>

Applied.

Thanks,
Linus Walleij
