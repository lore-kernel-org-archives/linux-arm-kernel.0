From: balbi@ti.com (Felipe Balbi)
Date: Mon, 9 Sep 2013 09:15:31 -0500
Subject: [PATCHv4] ARM: OMAP2+: am335x-bone*: add DT for BeagleBone Black
In-Reply-To: <1378734350-30479-1-git-send-email-koen@dominion.thruhere.net>
References: <1378734350-30479-1-git-send-email-koen@dominion.thruhere.net>
Message-ID: <20130909141531.GL9325@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 09, 2013 at 03:45:50PM +0200, Koen Kooi wrote:
> The BeagleBone Black is basically a regular BeagleBone with eMMC and HDMI added,
> so create a common dtsi both can use.
> 
> IMPORTANT: booting the existing am335x-bone.dts will blow up the HDMI transceiver 
> after a dozen boots with an uSD card inserted because LDO will be at 3.3V instead
> of 1.8. 
> 
> MMC support for AM335x still isn't in, so only the LDO change has been added.
> 
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> Tested-by: Tom Rini <trini@ti.com>
> Tested-by: Matt Porter <matt.porter@linaro.org>

not entirelly related to $SUBJECT but having HDMI listed in BBB DTS will
prevent the use of RF cape, no ?

Other than that, patch looks ok to me.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130909/c8f20985/attachment.sig>
