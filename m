From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 25 Oct 2018 10:08:53 -0300
Subject: [PATCH] ARM: dts: imx: Add dummy PHYs for HSIC-only USB
 controllers
In-Reply-To: <1539848729-27646-1-git-send-email-frieder.schrempf@kontron.de>
References: <1539848729-27646-1-git-send-email-frieder.schrempf@kontron.de>
Message-ID: <CAOMZO5CPPk6nqQdZ8KfXd=+B5m5R_hoOvz6pfPnR4kWeYkG2OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2018 at 5:00 AM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> Some SOCs in the i.MX6 family have a USB host controller that is
> only capable of the HSIC interface and has no on-board PHY.
>
> To be able to use these controllers, we need to add "usb-nop-xceiv"
> dummy PHYs.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
