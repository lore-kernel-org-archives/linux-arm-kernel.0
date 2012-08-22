From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Aug 2012 20:16:02 +0100
Subject: [PATCH v3 8/9] ARM: OMAP2+: McBSP: Do not create legacy devices
 when booting with DT data
In-Reply-To: <1345124468-8876-9-git-send-email-peter.ujfalusi@ti.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-9-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120822191601.GO7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 04:41:07PM +0300, Peter Ujfalusi wrote:
> Only create the devices in a legacy way if we do not have the DT data.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120822/ee4babf2/attachment.sig>
