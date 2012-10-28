From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 28 Oct 2012 20:06:17 +0100
Subject: [PATCH] dma: ste_dma40: use for_each_set_bit
In-Reply-To: <1351352973-3719-1-git-send-email-akinobu.mita@gmail.com>
References: <1351352973-3719-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <CACRpkdYiMu7fRGAhEfy7YfLon0CbC=6c5SwJ2kNP5JnwNaaKPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 27, 2012 at 5:49 PM, Akinobu Mita <akinobu.mita@gmail.com> wrote:

> Replace open-coded loop with for_each_set_bit().
>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>

Makes perfect sense to me,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
