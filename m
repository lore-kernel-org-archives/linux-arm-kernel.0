From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Mon, 24 Nov 2014 14:48:31 +0530
Subject: [PATCH V5 07/12] pinctrl: tegra-xusb: Add USB PHY support
In-Reply-To: <1416264102-1323-8-git-send-email-abrestic@chromium.org>
References: <1416264102-1323-1-git-send-email-abrestic@chromium.org>
 <1416264102-1323-8-git-send-email-abrestic@chromium.org>
Message-ID: <CAJe_ZheyfmX-bcuqGQk4vKA1DFJYgr69w2B_9rxf3POKHWqYyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 November 2014 at 04:11, Andrew Bresticker <abrestic@chromium.org> wrote:
> In addition to the PCIe and SATA PHYs, the XUSB pad controller also
> supports 3 UTMI, 2 HSIC, and 2 USB3 PHYs.  Each USB3 PHY uses a single
> PCIe or SATA lane and is mapped to one of the three UTMI ports.
>
> The xHCI controller will also send messages intended for the PHY driver,
> so request and listen for messages on the mailbox's PHY channel.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>

Mailbox bits look good to me.

-Jassi
