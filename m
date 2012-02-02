From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Feb 2012 12:41:12 +0000
Subject: [RFC 6/7] OMAP: omap4panda: Add fixed regulator for twl6040 needs
In-Reply-To: <1328185019-29575-7-git-send-email-peter.ujfalusi@ti.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
 <1328185019-29575-7-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120202124112.GG7428@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 02:16:58PM +0200, Peter Ujfalusi wrote:
> The twl6040 VIO power is connected to SMPS V1V8, the
> V2V1 power is coming from SMPS V2V1 of twl6030.
> These are fixed, always on regulators.
> Create fixed voltage regulators for these supplies.

Same issue as previously, shouldn't the PMIC create the regulators?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120202/2a44d37e/attachment.sig>
