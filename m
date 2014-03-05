From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 5 Mar 2014 17:13:01 +0800
Subject: [PATCH] pinctrl: sirf: fix kernel panic in gpio_lock_as_irq
In-Reply-To: <1394002503-2614-1-git-send-email-21cnbao@gmail.com>
References: <1394002503-2614-1-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdaiBn0OzaW9E7092j+34NzD5-Bf8hrix1kJXBksF1rGSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 5, 2014 at 2:55 PM, Barry Song <21cnbao@gmail.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> commit 655dada6277991 causes kernel panic, this patch fixes it.

Ufff sorry my fault. Patch applied for fixes.

Yours,
Linus Walleij
