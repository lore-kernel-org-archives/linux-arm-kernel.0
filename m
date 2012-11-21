From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Nov 2012 11:04:02 +0100
Subject: [PATCH 195/493] pinctl: remove use of __devinit
In-Reply-To: <1353349642-3677-195-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-195-git-send-email-wfp5p@virginia.edu>
Message-ID: <CACRpkdY4KxzDWd+8EqDTy5X2EBPrqy9_mPH59ghO1PaZsQ4Xvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 7:22 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:

> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Barry Song <baohua.song@csr.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: spear-devel at list.st.com

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
