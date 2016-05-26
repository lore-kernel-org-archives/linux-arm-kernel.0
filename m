From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 May 2016 11:08:42 +0200
Subject: [PATCH] pinctrl: samsung: Suppress unbinding to prevent
 theoretical attacks
In-Reply-To: <1463464926-17482-1-git-send-email-k.kozlowski@samsung.com>
References: <1463464926-17482-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CACRpkdYdo5XsJvb9GTYph7P=u31treiDX6HZGbG_AGzW5hp1HQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2016 at 8:02 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:

> Although unbinding a pinctrl driver requires root privileges but it
> still might be used theoretically in certain attacks (by triggering NULL
> pointer exception or memory corruption).

Patch applied with Javier's review tag.

I suspect this kind of patch should be done to a few
GPIO controller :/

Yours,
Linus Walleij
