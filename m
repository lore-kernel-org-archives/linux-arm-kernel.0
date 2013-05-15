From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 18:44:26 +0200
Subject: [PATCH 03/39] dmaengine: ste_dma40: Don't configure runtime
 configurable setup during allocate
In-Reply-To: <1368611522-9984-4-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbvhB=7QScU1bCN8wXr7ZOuPX9XYoCjX_a8gFSMCkbm-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Using the dmaengine API, allocating and configuring a channel are two
> separate actions. Here we're removing logical channel configuration from
> the channel allocating routines.

This commit message is also incorrect, but I amended it.

Besides, when I amend commit messages I make sure I really
understand what is going on so no big deal...

> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I still need Vinod's ACK on this before I send it anywhere.

Patch applied!

Yours,
Linus Walleij
