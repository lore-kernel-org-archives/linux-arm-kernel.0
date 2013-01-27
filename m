From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 27 Jan 2013 11:21:49 +0800
Subject: [PATCH] mc13892-regulator: correct/refine handling of the SWxHI
 bit
In-Reply-To: <1358789920-1341-1-git-send-email-matt@genesi-usa.com>
References: <1358789920-1341-1-git-send-email-matt@genesi-usa.com>
Message-ID: <20130127032146.GF4650@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 11:38:40AM -0600, Matt Sealey wrote:
> MC13892 PMIC supports a "HI" bit for 3 of it's 4 buck switcher outputs,
> which enables a higher set of voltage ranges.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130127/406ba013/attachment.sig>
