From: olof@lixom.net (Olof Johansson)
Date: Fri, 2 Nov 2018 11:26:36 -0700
Subject: [PATCH] ARM: defconfig: Update multi_v7 to use PREEMPT
In-Reply-To: <20181019092426.12052-1-linus.walleij@linaro.org>
References: <20181019092426.12052-1-linus.walleij@linaro.org>
Message-ID: <20181102182636.mjfofspqjzyb3o5q@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2018 at 11:24:26AM +0200, Linus Walleij wrote:
> Using CONFIG_PREEMPT as preemption model for ARMv7 systems
> appear to be the most reasonable default.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi ARM SoC folks, if you agree with this patch, please
> just apply it where and when appropriate.

Thanks, doing a round of fixes, so including it there.


-Olof
