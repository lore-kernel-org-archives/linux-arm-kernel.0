From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 24 May 2013 01:09:46 +0200
Subject: [PATCH 4/6] i2c: stu300: do not request a specific clock name
In-Reply-To: <1369330288-14856-5-git-send-email-linus.walleij@stericsson.com>
References: <1369330288-14856-1-git-send-email-linus.walleij@stericsson.com>
 <1369330288-14856-5-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130523230943.GA3645@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 07:31:26PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> We have used the default clock associated with the block
> for a long time, only heuristics in the clock system has
> made this work anyway. This needs to be done away with as
> we start probing this driver and its clocks exclusively
> from the device tree.
> 
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Wolfram Sang <wsa@the-dreams.de>
