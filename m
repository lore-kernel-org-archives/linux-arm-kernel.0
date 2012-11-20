From: viresh.kumar@linaro.org (viresh kumar)
Date: Tue, 20 Nov 2012 08:38:17 +0530
Subject: [PATCH 138/493] pinctrl: remove use of __devexit_p
In-Reply-To: <1353349642-3677-138-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-138-git-send-email-wfp5p@virginia.edu>
Message-ID: <CAOh2x=m_3j2PdDSy9MHC1kpxWs6uptQprTUS7vDKhptnRKcK3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 11:51 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:
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
>  drivers/pinctrl/spear/pinctrl-spear1310.c  | 2 +-
>  drivers/pinctrl/spear/pinctrl-spear1340.c  | 2 +-
>  drivers/pinctrl/spear/pinctrl-spear300.c   | 2 +-
>  drivers/pinctrl/spear/pinctrl-spear310.c   | 2 +-
>  drivers/pinctrl/spear/pinctrl-spear320.c   | 2 +-

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
