From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Nov 2012 23:44:21 +0100
Subject: [PATCH 064/493] hwspinlock: remove use of __devexit_p
In-Reply-To: <1353349642-3677-64-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-64-git-send-email-wfp5p@virginia.edu>
Message-ID: <CACRpkdbY7V50oZFiAj7+TaxcNFueB+f-ZMF21t0sn_STmsgoVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 7:20 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:

> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
