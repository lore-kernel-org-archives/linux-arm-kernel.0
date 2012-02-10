From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 10 Feb 2012 11:24:41 +0000
Subject: [PATCH 2/7] regulator: twl-regulator: Add fixed LDO for V1V8,
 V2V1 supply
In-Reply-To: <1328868316-24749-3-git-send-email-peter.ujfalusi@ti.com>
References: <1328868316-24749-1-git-send-email-peter.ujfalusi@ti.com>
 <1328868316-24749-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120210112441.GE3056@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2012 at 12:05:11PM +0200, Peter Ujfalusi wrote:
> V1V8 supply most common use is to provide VIO for the system.
> V2V1 supply is used on SDP4430/PandaBoards to provide 2.1V to
> twl6040, and also as an input to VCXIO_IN, VDAC_IN of twl6030.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I'll not apply this as it'll cause runtime breakage if it goes via a
different path to the rest of the series.  If it's getting near to the
merge window and nothing is applied please remind me and this can go in
by itself.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120210/74d77db7/attachment.sig>
