From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Dec 2013 18:52:36 +0000
Subject: [PATCH 2/2] ASoC: sgtl5000: clean up sgtl5000_enable_regulators()
In-Reply-To: <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
 <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20131218185236.GI31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 02:43:03PM +0800, Shawn Guo wrote:
> Function sgtl5000_enable_regulators() is somehow odd in handling the
> optional external VDDD supply.  The driver can only enable this supply
> on SGTL5000 chip before revision 0x11, and of course when this external
> VDDD is present.  It currently does something like below.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/48d33d91/attachment.sig>
