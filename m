From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Nov 2012 23:39:09 +0100
Subject: [PATCH 075/493] mfd: remove use of __devexit_p
In-Reply-To: <1353349642-3677-75-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-75-git-send-email-wfp5p@virginia.edu>
Message-ID: <CACRpkdbzOUAwt4SB5DSKaCpWOMx1FJc8M8Ej-adpu+jzH3dO9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 7:20 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:

> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Peter Tyser <ptyser@xes-inc.com>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: device-drivers-devel at blackfin.uclinux.org
> Cc: patches at opensource.wolfsonmicro.com
> Cc: linux-arm-msm at vger.kernel.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
