From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Sep 2016 15:27:10 +0200
Subject: [PATCH v3] gpio: Added zynq specific check for special pins on
 bank zero
In-Reply-To: <1474630018-9986-1-git-send-email-navam@xilinx.com>
References: <1474630018-9986-1-git-send-email-navam@xilinx.com>
Message-ID: <CACRpkdZOMo+8bmrXg3Tn7qDFqs-MbdU2ztYDZQGhaVuuG1cvVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 1:26 PM, Nava kishore Manne
<nava.manne@xilinx.com> wrote:

> From: Nava kishore Manne <nava.manne@xilinx.com>
>
> This patch adds zynq specific check for bank 0 pins 7 and 8
> are special and cannot be used as inputs
>
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> Reported-by: Jonas Karlsson <Jonas.d.karlsson@gmail.com>
> Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> ---
> Changes for v3:
>                 -Fixed some minor comments.

Patch applied.

Yours,
Linus Walleij
