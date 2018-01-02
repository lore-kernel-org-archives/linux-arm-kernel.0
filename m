From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Jan 2018 09:58:01 +0100
Subject: [PATCH] pinctrl/spear/plgpio: Delete two error messages for a
 failed memory allocation in plgpio_probe()
In-Reply-To: <66c3f488-ffdf-e55d-e511-e4af35e670b4@users.sourceforge.net>
References: <66c3f488-ffdf-e55d-e511-e4af35e670b4@users.sourceforge.net>
Message-ID: <CACRpkdbAJqrgghCV2tj4FdoPHweKYkze1s1UnmrvU71gqRVkAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 10:39 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 27 Dec 2017 22:34:28 +0100
>
> Omit extra messages for a memory allocation failure in this function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied with Viresh's ACK.

Yours,
Linus Walleij
