From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 Apr 2012 10:18:04 +0200
Subject: [PATCH 14/15] mfd/db8500-prcmu: Add Device Tree support and
 enable ux500 platforms
In-Reply-To: <1334867804-31942-15-git-send-email-lee.jones@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-15-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbQpa+YQ6SNytB-aW9Psr8jE1FO-=iyfJsF71RKmzzqUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 10:36 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Here we see the db8500-prcmu driver obtain DT support. In its
> current state, all we have to do is offer a matching compatible
> node and the driver will register and initialise correctly. We
> Also remove any initialisation completed in platform code to
> prevent any device duplication.
>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

OK I need Sam's ACK on this too, then it seems a good idea
to take all three patches touching the PRCMU driver through the
ux500-core tree.

Thanks,
Linus Walleij
