From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:12:47 +0200
Subject: [PATCH 17/32] dmaengine: ste_dma40: Remove redundant argument
 from d40_phy_cfg()
In-Reply-To: <1366279934-30761-18-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-18-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYuV+ZP8nW=PHgiw6KOjM9js9Mwd3-XVXCkH6wq213D0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:11 PM, Lee Jones <lee.jones@linaro.org> wrote:

> d40_phy_cfg is now only ever called to configure physical channels, so
> there's no requirement to pass though an argument describing the type
> of channel and to subsequently test for it.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

As mentioned, squash this into the patch where this is made redundant,
no point in first making an argument unused in one patch and then
deleting it in another patch.

Yours,
Linus Walleij
