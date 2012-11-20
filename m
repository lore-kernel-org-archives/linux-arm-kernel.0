From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Nov 2012 23:45:20 +0100
Subject: [PATCH 403/493] hwspinlock: remove use of __devexit
In-Reply-To: <1353349642-3677-403-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-403-git-send-email-wfp5p@virginia.edu>
Message-ID: <CACRpkdZCy_RwSTp+jm_sBmEroVn8YS3CAzvxvoN3uXoLDPWH=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 7:25 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:

> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.
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
