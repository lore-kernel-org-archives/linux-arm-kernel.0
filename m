From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Sep 2016 11:22:26 +0200
Subject: [PATCH] gpio: Added zynq specific check for special pins on bank
 zero
In-Reply-To: <1474360324-8168-1-git-send-email-navam@xilinx.com>
References: <1474360324-8168-1-git-send-email-navam@xilinx.com>
Message-ID: <CACRpkdb1R9TiVet3-9z5KhOugQmqvq-uS9j5aDApoa44284L4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2016 at 10:32 AM, Nava kishore Manne
<nava.manne@xilinx.com> wrote:

> From: Nava kishore Manne <nava.manne@xilinx.com>
>
> This patch adds zynq specific check for bank 0 pins 7 and 8
> are special and cannot be used as inputs
>
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>

I'm waiting for a revised version of this patch with comments adressed
and ACKs added.

Yours,
Linus Walleij
