From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Jan 2015 07:17:29 +0100
Subject: [RFC 05/15] gpio: move DT parsing code to separate functions
In-Reply-To: <1418226513-14105-6-git-send-email-a.hajda@samsung.com>
References: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
 <1418226513-14105-6-git-send-email-a.hajda@samsung.com>
Message-ID: <CACRpkdZLw=dTQ0zcHYSJ7rC5k3hjTJ-i__25eDyY8gz6PpnpsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 4:48 PM, Andrzej Hajda <a.hajda@samsung.com> wrote:

> The patch moves Device Tree parsing logic to separate
> function.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>

I think this patch need to be rebased on the GPIO devel branch, but
looks like it makes things cleaner so can stand on its own merits.
We moves stuff around a bit in the OF code though.

Please remember to send this patch to the linux-gpio list and comaintainer
Alexandre Courbot on reposts. (Cc-tags in the patch are good
for this.)

Yours,
Linus Walleij
