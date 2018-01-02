From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Jan 2018 09:59:20 +0100
Subject: [PATCH] pinctrl: spear: Delete an error message for a failed
 memory allocation in spear_pinctrl_probe()
In-Reply-To: <3d936763-6a8a-edd3-3bcf-0075c9343e37@users.sourceforge.net>
References: <3d936763-6a8a-edd3-3bcf-0075c9343e37@users.sourceforge.net>
Message-ID: <CACRpkdYSMmf9OHHpGi2aHyQo6Cu6pqGhMQhqUiguSqwG7NtMSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 10:48 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 27 Dec 2017 22:44:04 +0100
>
> Omit an extra message for a memory allocation failure in this function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied with Viresh's ACK.

Yours,
Linus Walleij
