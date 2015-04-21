From: broonie@kernel.org (Mark Brown)
Date: Tue, 21 Apr 2015 11:15:03 +0100
Subject: [RESEND RFC PATCH 2/3] ASoC: mediatek: Add AFE connection control
In-Reply-To: <20150421055041.GQ6325@pengutronix.de>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-3-git-send-email-koro.chen@mediatek.com>
 <20150418173740.GF26185@sirena.org.uk>
 <20150420045017.GI6325@pengutronix.de>
 <20150420205230.GK14892@sirena.org.uk>
 <20150421055041.GQ6325@pengutronix.de>
Message-ID: <20150421101503.GD22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 07:50:41AM +0200, Sascha Hauer wrote:

> Oh, that's not magic at all, the crossbar switch has inputs and outputs
> numbered from 0 to MTK_AFE_INTERCONN_NUM_INPUT /
> MTK_AFE_INTERCONN_NUM_OUTPUT (they have the same numbers in the
> datasheet. To connect input x with output y look at index [x][y] in the
> table and write the register values found at that place. If .creg is 0x0
> then it's not possible to connect the given input with the given output.

A comment saying that would help then.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150421/563f9fc2/attachment.sig>
