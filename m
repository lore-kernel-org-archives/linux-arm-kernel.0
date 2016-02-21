From: broonie@kernel.org (Mark Brown)
Date: Sun, 21 Feb 2016 09:38:59 +0900
Subject: [PATCH V6 1/2] regulator: Add document for MT6323 regulator
In-Reply-To: <1455709056-50510-1-git-send-email-blogic@openwrt.org>
References: <1455709056-50510-1-git-send-email-blogic@openwrt.org>
Message-ID: <20160221003859.GI18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 12:37:35PM +0100, John Crispin wrote:
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: devicetree at vger.kernel.org

...and dropped due to the dependency on MFD changes that you didn't
mention :/  I can't apply this without a pull request from Lee with the
MFD changes for the chip that I can depend on, there's no separate
Kconfig symbol and the MFD is already merged causing build failures
(you've had mail from 0day about that).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160221/81493bbd/attachment.sig>
