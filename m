From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Nov 2012 11:03:40 +0100
Subject: [PATCH 138/493] pinctrl: remove use of __devexit_p
In-Reply-To: <1353349642-3677-138-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-138-git-send-email-wfp5p@virginia.edu>
Message-ID: <CACRpkdbh5Eb8s57gDwJ+hjyiJzAO-x-9xDBMTPJ-nwR-+jDeaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 7:21 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:

> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: spear-devel at list.st.com

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
