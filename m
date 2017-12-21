From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Dec 2017 10:20:54 +0100
Subject: [PATCH 2/2] pinctrl/nomadik/abx500: Improve a size determination
 in abx500_gpio_probe()
In-Reply-To: <93beb4d9-99e2-e7f2-e752-2d7228a8df46@users.sourceforge.net>
References: <e5be1da7-460d-a47d-59b8-c1902907f5a4@users.sourceforge.net>
 <93beb4d9-99e2-e7f2-e752-2d7228a8df46@users.sourceforge.net>
Message-ID: <CACRpkdYepPFNq6SLUbkr+=UasPzq2mVQg_a9eKK_WNVmnF1FDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 10:52 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 20 Dec 2017 10:22:53 +0100
>
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied.

Yours,
Linus Walleij
