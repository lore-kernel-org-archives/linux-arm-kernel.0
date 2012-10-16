From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 16 Oct 2012 13:44:09 +0200
Subject: [PATCH] mmc: mmci: Fixup and cleanup code for DMA handling
In-Reply-To: <CACRpkdZPbrvfk0QNB7x8YZ+DVibPJMTLsLDSf310CcBEeOTuww@mail.gmail.com>
References: <1350056012-18625-1-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdZqe3uB9wGM5g5LUJuZEtzeBW=Hs5RF=5_CKU0CBWJRyA@mail.gmail.com>
 <CAPDyKFr=aN+MN+VCvbAqNa7mu+fxTTeHdcA1oCv8QWqpdT8MGQ@mail.gmail.com>
 <CACRpkdZPbrvfk0QNB7x8YZ+DVibPJMTLsLDSf310CcBEeOTuww@mail.gmail.com>
Message-ID: <CAPDyKFqfjaDcj361eoMtp3BwQMAW5JcUcyoovFPzXdL0a3dzUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 October 2012 10:17, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Oct 16, 2012 at 9:16 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> This code has not been tested on a "legacy" ARM PL180 but only for
>> ux500 boards. Even if it should affect DMA handling we should test
>> this properly. Would be great if you were able to help out, I guess
>> you still have available hardware for these tests?
>
> I can test the Integrator/CP and Realview in IRQ/PIO mode and
> the U300 in DMA mode.

Great!

>
> I need some help to provoke errorpath in DMA mode though,
> so any hints are welcome...

One good option could be to stress test card insert/removal sequences,
while at the same time doing read/write requests.

>
> Yours,
> Linus Walleij

Kind regards
Ulf Hansson
