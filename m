From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 20:27:55 +0200
Subject: [PATCH 1/4] pinctrl: sirf: wrap all gpio banks into one gpio_chip
In-Reply-To: <1397544229-20545-2-git-send-email-21cnbao@gmail.com>
References: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
 <1397544229-20545-2-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdZ5e=3SzQxvhzEJ=jyOPzqjZ1LfU0CtYscREsNXyFf+bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 8:43 AM, Barry Song <21cnbao@gmail.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> all gpio banks are in one chip, that makes software clean in mapping
> irq and gpio.
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

These all look good, but for some reason does not apply on top of
the pinctrl "devel" branch based on v3.15-rc2. Can you please rebase
this set onto my branch or atleast v3.15-rc2 and resend?

Yours,
Linus Walleij
