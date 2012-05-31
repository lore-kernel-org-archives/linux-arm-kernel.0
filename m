From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:55:33 +0800
Subject: [PATCH RFC 0/3] i2c-nomadik changes
In-Reply-To: <cover.1338398567.git.rubini@gnudd.com>
References: <cover.1338398567.git.rubini@gnudd.com>
Message-ID: <CACRpkdZqD0_5oRwBg2J7ZyCK9=ynGOZnSWrQmtCyph9C3W3jDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 1:45 AM, Alessandro Rubini <rubini@gnudd.com> wrote:

> In the STA2X11 I/O hub we are exporting a number of AMBA peripherals
> to the PCI world. Using a generic pci-amba driver there is no further
> code for each device, provided they are already registered under the
> AMBA bus. ?I already submitted the generic bridge
> (https://lkml.org/lkml/2012/5/28/194).

Yeah I buy this concept, it's a good way to share this code.

> The cell-id I used in the table are the one for ux500 (only as far as
> I know from the stn-8815 manuals) and the one for STA2X11.

I've tried a few times to get this driver working on the S8815 Calao
dongle version of Nomadik 8815, but failed miserably (I managed
to get DMA and MMC working, which I will likely try to merge.)
I'm still trying to figure out why sometimes now and then.

So this doesn't make anything worse anyway.

Thanks for this nice patch set!

Yours,
Linus Walleij
