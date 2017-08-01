From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Aug 2017 15:27:06 +0200
Subject: [PATCH 2/2] pinctrl: zynq: Fix warnings in the driver
In-Reply-To: <4ec0134906b80ac107dfc80fbf7beb10e38e47cb.1499937148.git.michal.simek@xilinx.com>
References: <4c6e1f9b0635682518d2ffa50cf611efef4aff68.1499937148.git.michal.simek@xilinx.com>
 <4ec0134906b80ac107dfc80fbf7beb10e38e47cb.1499937148.git.michal.simek@xilinx.com>
Message-ID: <CACRpkdYxQOjzJTG2ENt4uo2K86+v-PzUr_zVmWcZOu19-979tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 11:12 AM, Michal Simek <michal.simek@xilinx.com> wrote:

> From: Nava kishore Manne <nava.manne@xilinx.com>
>
> This patch fixes the below warning
>         --> Prefer 'unsigned int' to bare use of 'unsigned'.
>         --> line over 80 characters.
>         --> Prefer 'unsigned int **' to bare use of 'unsigned **'.
>
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Patch applied.

Yours,
Linus Walleij
