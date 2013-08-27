From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Aug 2013 05:20:45 +0200
Subject: [PATCH v2] gpio: Enable pcf857x GPIO expander for Device Tree
In-Reply-To: <1377498081-16358-1-git-send-email-archit@ti.com>
References: <1370527523-1030-1-git-send-email-archit@ti.com>
 <1377498081-16358-1-git-send-email-archit@ti.com>
Message-ID: <CACRpkda5Q-Zs8A2VFPvMc9519QWJ3EH08g4Do0se6BcLEg+rug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 8:21 AM, Archit Taneja <archit@ti.com> wrote:

> Add code to parse the GPIO expander Device Tree node and extract platform data
> out of it, and populate the struct 'pcf857x_platform_data' maintained by the
> driver. This enables devices to reference the gpio expander from Device Tree.
>
> Add DT binding info in Documentation.
>
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
> - v2 posted after quite a while, sorry for the delay!
>
> Changes in v2:
> - second gpeio-cell description corrected in Documentation
> - interrupt controller description removed for now, will be added in a follow
>   up patch
> - n_latch description updated

The devicetree portions of this patch needs to be reviewed by
devicetree at vger.kernel.org, so please repost including that
list.

Yours,
Linus Walleij
