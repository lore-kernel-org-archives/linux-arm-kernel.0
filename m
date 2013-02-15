From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Feb 2013 15:53:03 +0100
Subject: [PATCH 4/6] dma: coh901318_lli: set residue only if dma is in
 progress
In-Reply-To: <1360666720-19006-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1360666720-19006-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1360666720-19006-5-git-send-email-andriy.shevchenko@linux.intel.com>
Message-ID: <CACRpkdaW+bksgQR+TG1tbvLgaWEFHihfSvz_dUy1PR-5YQssTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 11:58 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> When status is DMA_SUCCESS the residue should be zero. Otherwise it's a bug.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
