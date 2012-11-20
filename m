From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Nov 2012 23:37:29 +0100
Subject: [PATCH 1/2] ARM: ux500: Disable the MMCI gpio-regulator by default
In-Reply-To: <1352985288-29518-1-git-send-email-lee.jones@linaro.org>
References: <1352985288-29518-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdY4Ej9YZMbTLUD80bL8MnM-+TCU=LJ3Vsdskh7DLc1cgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 2:14 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Not all supported boards will require a MMCI gpio-regulator,
> therefore it's a good idea to only enable the node when and if
> it is required. Let's disable it by default.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Sorry for the delay.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
