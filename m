From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 22 May 2018 00:55:58 +0300
Subject: [PATCH 17/33] pinctrl: armada-37xx: use match_string() helper
In-Reply-To: <1526903890-35761-18-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-18-git-send-email-xieyisheng1@huawei.com>
Message-ID: <CAHp75Ve5yRKZK5mcCsRBKGevN6jPN++WnQZnc4eetOoKXvxR1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.

https://patchwork.kernel.org/patch/10378781/

> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-gpio at vger.kernel.org

-- 
With Best Regards,
Andy Shevchenko
