From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Nov 2012 11:03:19 +0100
Subject: [PATCH 417/493] pinctrl: remove use of __devexit
In-Reply-To: <1353349642-3677-417-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-417-git-send-email-wfp5p@virginia.edu>
Message-ID: <CACRpkdbbZ1755u+44GttPCZ4iDos89vkHZgnTdVXH-TeiPsW1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 7:26 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:

> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: spear-devel at list.st.com

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
