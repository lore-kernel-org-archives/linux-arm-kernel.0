From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 26 Nov 2018 22:02:10 +0800
Subject: [PATCH] ARM: dts: imx: Add dummy PHYs for HSIC-only USB
 controllers
In-Reply-To: <1539848729-27646-1-git-send-email-frieder.schrempf@kontron.de>
References: <1539848729-27646-1-git-send-email-frieder.schrempf@kontron.de>
Message-ID: <20181126140208.GA31334@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2018 at 09:45:04AM +0200, Frieder Schrempf wrote:
> Some SOCs in the i.MX6 family have a USB host controller that is
> only capable of the HSIC interface and has no on-board PHY.
> 
> To be able to use these controllers, we need to add "usb-nop-xceiv"
> dummy PHYs.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied, thanks.
