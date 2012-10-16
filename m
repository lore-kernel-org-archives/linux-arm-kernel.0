From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Oct 2012 10:17:59 +0200
Subject: [PATCH] mmc: mmci: Fixup and cleanup code for DMA handling
In-Reply-To: <CAPDyKFr=aN+MN+VCvbAqNa7mu+fxTTeHdcA1oCv8QWqpdT8MGQ@mail.gmail.com>
References: <1350056012-18625-1-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdZqe3uB9wGM5g5LUJuZEtzeBW=Hs5RF=5_CKU0CBWJRyA@mail.gmail.com>
 <CAPDyKFr=aN+MN+VCvbAqNa7mu+fxTTeHdcA1oCv8QWqpdT8MGQ@mail.gmail.com>
Message-ID: <CACRpkdZPbrvfk0QNB7x8YZ+DVibPJMTLsLDSf310CcBEeOTuww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 9:16 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> This code has not been tested on a "legacy" ARM PL180 but only for
> ux500 boards. Even if it should affect DMA handling we should test
> this properly. Would be great if you were able to help out, I guess
> you still have available hardware for these tests?

I can test the Integrator/CP and Realview in IRQ/PIO mode and
the U300 in DMA mode.

I need some help to provoke errorpath in DMA mode though,
so any hints are welcome...

Yours,
Linus Walleij
