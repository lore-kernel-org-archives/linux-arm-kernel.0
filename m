From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Nov 2013 13:39:58 +0100
Subject: [PATCH v4 1/6] gpio: davinci: Fixed a check for unbanked gpio
In-Reply-To: <1383406775-14902-2-git-send-email-prabhakar.csenng@gmail.com>
References: <1383406775-14902-1-git-send-email-prabhakar.csenng@gmail.com>
 <1383406775-14902-2-git-send-email-prabhakar.csenng@gmail.com>
Message-ID: <CACRpkdZ7pwGQnK0NN4tybLUNdMxu5WVaGX8Dqu+kMgVBuyF16w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 2, 2013 at 4:39 PM, Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:

> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>
> This patch fixes the check for the offset in
> gpio_to_irq_unbanked() function.
>
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Is this a regression that should go in right now?

Yours,
Linus Walleij
