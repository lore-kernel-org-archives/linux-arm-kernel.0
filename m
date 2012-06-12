From: mturquette@ti.com (Mike Turquette)
Date: Tue, 12 Jun 2012 11:08:10 -0700
Subject: [PATCH 4/7] ARM: nomadik: convert to generic clock
In-Reply-To: <1339018506-29126-1-git-send-email-linus.walleij@linaro.org>
References: <1339018506-29126-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20120612180810.GG19410@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120606-23:35, Linus Walleij wrote:
> Remove more custom stuff by simply converting the Nomadik machine
> to use generic clocks and move the driver to drivers/clk.
> 
> Cc: Mike Turquette <mturquette@ti.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Looks like you've already sent a pull request for this to arm-soc.  FWIW
you can add my Acked-by for this patch.

Regards,
Mike
