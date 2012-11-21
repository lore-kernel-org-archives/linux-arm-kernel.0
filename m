From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 21 Nov 2012 11:36:49 +0100
Subject: [PATCH 138/493] pinctrl: remove use of __devexit_p
In-Reply-To: <1353349642-3677-138-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-138-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121121103649.GV4398@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:21 Mon 19 Nov     , Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Linus Walleij <linus.walleij@linaro.org> 
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com> 
> Cc: Viresh Kumar <viresh.linux@gmail.com> 
> Cc: linux-arm-kernel at lists.infradead.org 
> Cc: spear-devel at list.st.com 
> ---
>  drivers/pinctrl/mvebu/pinctrl-armada-370.c | 2 +-
>  drivers/pinctrl/mvebu/pinctrl-armada-xp.c  | 2 +-
>  drivers/pinctrl/mvebu/pinctrl-dove.c       | 2 +-
>  drivers/pinctrl/mvebu/pinctrl-kirkwood.c   | 2 +-
>  drivers/pinctrl/pinctrl-at91.c             | 2 +-
for at91

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
