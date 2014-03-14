From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Mar 2014 10:28:34 +0100
Subject: [PATCH] irq: Consider a negative return value of irq_startup() as
 an error
In-Reply-To: <alpine.DEB.2.02.1403121555140.18573@ionos.tec.linutronix.de>
References: <1393345719-3707-1-git-send-email-jjhiblot@traphandler.com>
 <alpine.DEB.2.02.1402262119560.4174@ionos.tec.linutronix.de>
 <CACRpkdZ6D1XfDBdJEcR8G2HWkNcZSfz08Yvx8f0s+CqTUmybkg@mail.gmail.com>
 <alpine.DEB.2.02.1403080857160.18573@ionos.tec.linutronix.de>
 <CACRpkdb=51_D6kxWcmSSRdr3kROXiwJbRzQDS-1VxEJpBjVyUA@mail.gmail.com>
 <alpine.DEB.2.02.1403121555140.18573@ionos.tec.linutronix.de>
Message-ID: <CACRpkdaDo5uQVWQ-BxLbGJcjQVYc7+oBczH3tUD1-syFi1oQfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 4:10 PM, Thomas Gleixner <tglx@linutronix.de> wrote:

> I pushed out the patch to a separate branch
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip irq/for-gpio
>
> and merged that branch back into irq/core.
>
> So you can just pull irq/for-gpio into the gpio work and base the gpio
> related changes on top of that. Just mention it in the pull request to
> the other Linus that it contains an irq/core change which avoids merge
> dependencies.

OK I first merged in the v3.14-rc6 as base and then pulled this in,
so I will proceed to switch the calls over to request/release
resources.

Yours,
Linus Walleij
