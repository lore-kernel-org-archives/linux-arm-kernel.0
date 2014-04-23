From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Apr 2014 22:03:39 +0200
Subject: [PATCH 1/4] pinctrl: sirf: wrap all gpio banks into one gpio_chip
In-Reply-To: <1397544229-20545-2-git-send-email-21cnbao@gmail.com>
References: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
 <1397544229-20545-2-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdZOcdgiHxZW_+Do9kd7A_jOpTjEpwfL8Lj7wWjQ_V+o2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 8:43 AM, Barry Song <21cnbao@gmail.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> all gpio banks are in one chip, that makes software clean in mapping
> irq and gpio.
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Patch applied!

Yours,
Linus Walleij
