From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Aug 2016 11:23:07 +0200
Subject: [PATCH] pinctrl: meson: get rid of unneeded domain structures
In-Reply-To: <1471110078-5946-1-git-send-email-b.galvani@gmail.com>
References: <1471110078-5946-1-git-send-email-b.galvani@gmail.com>
Message-ID: <CACRpkdbnXjOBP7KtFa+0_u9fVrqNRtBvskOwPggGbA5yW7RgDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 13, 2016 at 7:41 PM, Beniamino Galvani <b.galvani@gmail.com> wrote:

> The driver originally supported more domains (register ranges) per
> pinctrl device, but since commit 9dab1868ec0d ("pinctrl: amlogic: Make
> driver independent from two-domain configuration") each device gets
> assigned a single domain and we instantiate multiple pinctrl devices
> in the DT.
>
> Therefore, now the 'meson_domain' and 'meson_domain_data' structures
> don't have any reason to exist and can be removed to make the model
> simpler to understand. This commit doesn't change behavior.
>
> Tested on a Odroid-C2.
>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>

Patch applied with Kevin's ACK/Test tags.

Yours,
Linus Walleij
