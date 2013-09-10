From: olof@lixom.net (Olof Johansson)
Date: Mon, 9 Sep 2013 17:35:08 -0700
Subject: [PATCH 1/2] ARM: integrator_cp: Set LCD{0,1} enable lines when
 turning on CLCD
In-Reply-To: <1377798071-26790-1-git-send-email-jonathan.austin@arm.com>
References: <1377798071-26790-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <20130910003508.GB31153@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 06:41:11PM +0100, Jonathan Austin wrote:
> This turns on the internal integrator LCD display(s). It seems that the code
> to do this got lost in refactoring of the CLCD driver.
> 
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Cc: stable at vger.kernel.org
> 
> ---
> ...resending this patch to arm at kernel.org as suggested by Linus W with this Ack

Applied to fixes.


-Olof
