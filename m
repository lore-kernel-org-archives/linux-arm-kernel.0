From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 30 Jun 2012 12:42:53 +0100
Subject: [PATCH V2] ARM: dt: tegra: ventana: add regulators
In-Reply-To: <1341007486-16429-1-git-send-email-swarren@wwwdotorg.org>
References: <1341007486-16429-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120630114253.GU28922@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 04:04:46PM -0600, Stephen Warren wrote:

> ldo0: The HW default is 1.2v. On similar board designs, this rail is
> typically used for the PCIe clock which requires 3.3v. Note that this
> rail isn't actually used on this board.

If it's not used at all it should probably be omitted from the DT
entirely.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120630/99489c9c/attachment.sig>
