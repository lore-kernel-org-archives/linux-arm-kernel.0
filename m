From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Apr 2011 18:49:17 +0200
Subject: [PATCH v2 00/12] mmc: use nonblock mmc requests to minimize
	latency
In-Reply-To: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
Message-ID: <BANLkTikZVDejarZ4O5KgNS7S4fxBLSmANA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 6, 2011 at 9:07 PM, Per Forlin <per.forlin@linaro.org> wrote:

> The intention for introducing none blocking mmc requests is to minimize the
> time between a mmc request ends and another mmc request starts.

Acked-by: Linus Walleij <linus.walleij@linaro.org> FWIW, I've looked at the
patches so many times I'm already blind for any remaining bugs...

Yours,
Linus Walleij
