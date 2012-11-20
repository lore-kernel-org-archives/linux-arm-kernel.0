From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Nov 2012 23:44:36 +0100
Subject: [PATCH 253/493] hwspinlock: remove use of __devinit
In-Reply-To: <1353349642-3677-253-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-253-git-send-email-wfp5p@virginia.edu>
Message-ID: <CACRpkdZtKAmFN7R2sSvQN3cb_wKMt9+AK=getXf+Y=Cnf=giHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 7:23 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:

> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
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
