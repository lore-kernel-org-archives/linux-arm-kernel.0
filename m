From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:17:00 +0200
Subject: [PATCH 19/32] dmaengine: ste_dma40: Move more setup into the
 configuration routines
In-Reply-To: <1366279934-30761-20-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-20-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZKib-pm3QcJ6e4MnPfjvBp1kJUB3QXeb2ie=kUhshdew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:12 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The less configuration we can do during the allocation of a channel the
> better. As this will mean the likelihood of requiring extra information
> which isn't normally passed through the dma_request_channel() is lessened.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

NAK. You're breaking memcpy.

Yours,
Linus Walleij
