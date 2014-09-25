From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Sep 2014 15:19:28 +0200
Subject: [PATCH 02/27] dmaengine: ste_dma: use
 pm_runtime_last_busy_and_autosuspend helper
In-Reply-To: <1411575342-31048-3-git-send-email-vinod.koul@intel.com>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
 <1411575342-31048-3-git-send-email-vinod.koul@intel.com>
Message-ID: <CACRpkdZCzWyNVTL4+hDqvvE50hP71jyg7=+cH70tnCDF6_Q8Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 6:14 PM, Vinod Koul <vinod.koul@intel.com> wrote:

> Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
> coding the same code
>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
