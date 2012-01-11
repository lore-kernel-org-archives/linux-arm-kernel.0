From: rubini@unipv.it (Alessandro Rubini)
Date: Wed, 11 Jan 2012 10:41:48 +0100
Subject: [PATCH 2/3] plat-nomadik: handle clocking properly
In-Reply-To: <1326272693-5709-1-git-send-email-linus.walleij@stericsson.com>
References: <1326272693-5709-1-git-send-email-linus.walleij@stericsson.com> 
Message-ID: <20120111094148.GA28792@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> clk_prepare() was missing from the Nomadik MTU driver, also handle
> errors on prepare and enable in the simplest way possible, by
> bugging out - we cannot start the system without time anyway.
>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Alessandro Rubini <rubini@unipv.it>

/alessandro
