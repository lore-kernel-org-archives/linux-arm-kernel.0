From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Dec 2012 10:18:41 +0100
Subject: [PATCH 09/12] ARM: ux500: Use the correct name when supplying a
 GPIO enable pin
In-Reply-To: <1355129761-8088-10-git-send-email-lee.jones@linaro.org>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
 <1355129761-8088-10-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbQV-WgPjoJpKsGj6+wanwmT4rhYCoe_-A01phvNx6r1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 9:55 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Correct a typo in the Device Tree source file, where instead of
> specifying property 'enable-gpio', which the driver is expecting
> we specified 'gpio-enable' instead.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
