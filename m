From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Mar 2017 10:40:17 +0100
Subject: [PATCH] pinctrl: qcom: qdf2xxx: add names to the gpios
In-Reply-To: <1488843122-7960-1-git-send-email-timur@codeaurora.org>
References: <1488843122-7960-1-git-send-email-timur@codeaurora.org>
Message-ID: <CACRpkdZE2kawSKaukwbdDHPKfzeAvMCMe8ZTGWB8FvPqObruDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 7, 2017 at 12:32 AM, Timur Tabi <timur@codeaurora.org> wrote:

> The sysfs and debugfs entries for pin control drivers work better when
> the individual pins are given real names, even if they are all just
> "gpio0", "gpio1", etc.
>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

Patch tentatively applied (looks right to me), unless Bj?rn has concerns.

Is this a problem in other qcom pinctrl drivers?

Yours,
Linus Walleij
