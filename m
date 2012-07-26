From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jul 2012 22:25:16 +0100
Subject: [PATCH 1/2] sound: tegra_wm8903: Adjust to of_get_named_gpio()
 change
In-Reply-To: <1340037743-12924-1-git-send-email-stigge@antcom.de>
References: <1340037743-12924-1-git-send-email-stigge@antcom.de>
Message-ID: <20120726212515.GH4560@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 06:42:21PM +0200, Roland Stigge wrote:
> of_get_named_gpio() was changed to return -EPROBE_DEFER in case of
> gpios not probed yet. This patch adjusts tegra_wm8903 to this.

Applied both, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/7742a608/attachment.sig>
