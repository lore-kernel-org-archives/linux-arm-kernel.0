From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Feb 2013 10:29:38 -0800
Subject: [PATCH] ARM: nomadik: fix OF compilation regression
In-Reply-To: <1359708725-21978-1-git-send-email-linus.walleij@stericsson.com>
References: <1359708725-21978-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130205182938.GA21449@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 09:52:05AM +0100, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The Nomadik Device Tree patch series accidentally
> selected OF instead of USE_OF which led to problems
> during compile:
> 
> arch/arm/kernel/devtree.c: In function 'arm_dt_memblock_reserve':
> /home/elinwal/linux-arm-soc/arch/arm/kernel/devtree.c:43:7: error: 'initial_boot_params' undeclared (first use in this function)
> (etc).
> 
> This fixes it up by selecting USE_OF instead.


Applied, thanks.


-Olof
