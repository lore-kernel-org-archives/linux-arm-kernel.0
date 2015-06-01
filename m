From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 1 Jun 2015 14:46:34 +0200
Subject: [RFC v1 06/25] pinctrl: Use irq_desc_get_xxx() to avoid redundant
 lookup of irq_desc
In-Reply-To: <1432116013-25902-7-git-send-email-jiang.liu@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
 <1432116013-25902-7-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <CACRpkdazXuq7WZZPiObRNFBTokazUN9yisU7VNobS4ezgZTHJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 11:59 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:

> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
> already have a pointer to corresponding irq_desc.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Are there dependencies on this patch or can I just apply it
directly to the GPIO tree?

Yours,
Linus Walleij
