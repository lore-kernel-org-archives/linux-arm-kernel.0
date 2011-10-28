From: jeff@garzik.org (Jeff Garzik)
Date: Fri, 28 Oct 2011 16:36:58 -0400
Subject: [PATCH] ARM: mark empty gpio.h files empty
In-Reply-To: <1319833142-4764-1-git-send-email-linus.walleij@linaro.org>
References: <1319833142-4764-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <4EAB126A.5090507@garzik.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2011 04:19 PM, Linus Walleij wrote:
> It is generally a better idea to make intentionally empty files
> contain the human-readable /* empty */ comment, also it makes
> the files play nice with "make distclean".
>
> Reported-by: Jeff Garzik<jeff@garzik.org>
> Signed-off-by: Linus Walleij<linus.walleij@linaro.org>

Thanks!

Acked-by: Jeff Garzik <jgarzik@redhat.com>
