From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Sep 2014 18:22:50 +0200
Subject: [PATCH 1/3] gpio: zynq: Mask non-wakeup GPIO interrupts on suspend
In-Reply-To: <1409335127-26712-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1409335127-26712-1-git-send-email-soren.brinkmann@xilinx.com>
 <1409335127-26712-2-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <CACRpkdbn9XiBXcTr+znxu9MxLdUT5XpSoTdnPKRcfDJyG5cwuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 7:58 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> From: Ezra Savard <ezra.savard@xilinx.com>
>
> Added flag to the GPIO chip so that IRQ from non-wakeup GPIO will
> not wake the system.
>
> Signed-off-by: Ezra Savard <ezra.savard@xilinx.com>
> Reviewed-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Patch applied.

Yours,
Linus Walleij
