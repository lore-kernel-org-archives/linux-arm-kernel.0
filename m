From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Dec 2015 10:03:59 +0100
Subject: [PATCH] pinctrl: nsp-gpio: fix type of iterator
In-Reply-To: <1450867041-729-2-git-send-email-a.hajda@samsung.com>
References: <1450867041-729-1-git-send-email-a.hajda@samsung.com>
 <1450867041-729-2-git-send-email-a.hajda@samsung.com>
Message-ID: <CACRpkdZB60Zj3JP=ZT6R_C2DacwLPFwb-m2MJkCf-fiJNkN05w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 11:37 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:

> Iterator i declared as unsigned is always non-negative so the
> loop will never end.
>
> The problem has been detected using proposed semantic patch
> scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].
>
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2038576
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>

I already applied Dan Carpenters fix, somehow it was earlier
in my mail flow. Thanks anyways!

Yours,
Linus Walleij
