From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Mar 2012 12:50:03 +0000
Subject: [PATCH 2/2] ASoC: OMAP: Build config cleanup for McBSP
In-Reply-To: <1331283078-14846-3-git-send-email-peter.ujfalusi@ti.com>
References: <1331283078-14846-1-git-send-email-peter.ujfalusi@ti.com>
 <1331283078-14846-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120309125003.GY3273@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 10:51:18AM +0200, Peter Ujfalusi wrote:
> The McBSP driver stack has been moved, and rewritten resulting a single
> driver - selected by CONFIG_SND_OMAP_SOC_MCBSP. There is no longer need to
> have CONFIG_OMAP_MCBSP anymore.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/96c80f9a/attachment-0001.sig>
