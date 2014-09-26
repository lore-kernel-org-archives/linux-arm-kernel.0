From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 26 Sep 2014 10:38:38 +0200
Subject: [PATCH 11/27] mfd: ab8500-gpadc: use
 pm_runtime_last_busy_and_autosuspend helper
In-Reply-To: <1411575342-31048-12-git-send-email-vinod.koul@intel.com>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
 <1411575342-31048-12-git-send-email-vinod.koul@intel.com>
Message-ID: <CACRpkdZdEJndkE5mpkoUMN-do=LU8fMpkyjJb0RQnOjJYGRQqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 6:15 PM, Vinod Koul <vinod.koul@intel.com> wrote:

> Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
> coding the same code
>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
