From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 6 Mar 2012 12:14:30 +0000
Subject: [PATCH 2/2] regulator: Remove bq24022 regulator driver
In-Reply-To: <201203021357.44770.heiko@sntech.de>
References: <201203021355.21669.heiko@sntech.de>
 <201203021357.44770.heiko@sntech.de>
Message-ID: <20120306121429.GL19635@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2012 at 01:57:44PM +0100, Heiko St?bner wrote:
> The bq24022 driver is just a specialised form of a gpio-regulator.
> 
> As all former users of it now use the gpio-regulator directly, there
> is no need to keep it around.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120306/46fc976f/attachment.sig>
