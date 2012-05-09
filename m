From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 May 2012 10:48:03 +0200
Subject: [PATCH 03/15] ARM: ux500: Provide auxdata to be used as name base
 clock search for nmk-i2c
In-Reply-To: <1336155805-18554-4-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZDrwhD+1+RtdFUyDBC=bHKtbvx_9fyyATmS95V6RU-iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 4, 2012 at 8:23 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This patch provides a way for find_clk() to complete its name-based
> searches and still find the nmk-i2c clocks. As Device Tree has a
> different naming structure to that of more traditional initialisation
> methods, find_clk() not succeed without these bindings.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
