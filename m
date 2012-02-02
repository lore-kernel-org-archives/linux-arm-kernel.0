From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Feb 2012 12:42:04 +0000
Subject: [RFC 3/7] ASoC: twl6040: Remove dependency on twl4030 from Kconfig
In-Reply-To: <1328185019-29575-4-git-send-email-peter.ujfalusi@ti.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
 <1328185019-29575-4-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120202124203.GH7428@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 02:16:55PM +0200, Peter Ujfalusi wrote:
> twl6040 no longer needs twl4030.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Not applying since this needs to follow on from (or be integrated with)
the patch splitting the twl6040 to avoid build breaks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120202/be79ae3e/attachment.sig>
