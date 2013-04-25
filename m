From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:15:58 +0200
Subject: [PATCH 18/32] dmaengine: ste_dma40: Don't configure runtime
 configurable setup during allocate
In-Reply-To: <1366279934-30761-19-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-19-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbt0NxDoBa9=Y4eq3FH75pnMT_BkE6Tk-15=H0qnQWaHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:12 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Using the dmaengine API, allocating and configuring a channel are two
> separate actions. Here we're removing logical channel configuration from
> the channel allocating routines.

NAK: this is not true for memcpy.

Yours,
Linus Walleij
