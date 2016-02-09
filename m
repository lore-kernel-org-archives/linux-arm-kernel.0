From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Feb 2016 12:36:49 +0000
Subject: [PATCH V5 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <1454874037-38905-2-git-send-email-blogic@openwrt.org>
References: <1454874037-38905-1-git-send-email-blogic@openwrt.org>
 <1454874037-38905-2-git-send-email-blogic@openwrt.org>
Message-ID: <20160209123649.GD13270@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 07, 2016 at 08:40:37PM +0100, John Crispin wrote:

> * remove the code allows mode changes

That was excessive, there's no problem having set_mode() operations and
we can currently use them for static configurations.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/952d1a9e/attachment.sig>
