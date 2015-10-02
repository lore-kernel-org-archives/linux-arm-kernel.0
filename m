From: broonie@kernel.org (Mark Brown)
Date: Fri, 2 Oct 2015 18:33:38 +0100
Subject: [PATCH 6/6] ARM: i.MX6 Phytec PFLA02: Add supplies for the SoC
 internal regulators
In-Reply-To: <1443621946-8712-7-git-send-email-s.hauer@pengutronix.de>
References: <1443621946-8712-1-git-send-email-s.hauer@pengutronix.de>
 <1443621946-8712-7-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20151002173338.GA12635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 04:05:46PM +0200, Sascha Hauer wrote:
> The SoC internal regulators for the CPU and the SoC come from the
> DA9063 vdd_core and vdd_soc. Add this relationship to the device tree
> so that the voltage drop on the SoC internal LDO regulators can be
> minimized.

Acked-by: Mark Brown <broonie@kernel.org>

(the binding is fine so I think we can merge this already.)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151002/96b9bce8/attachment.sig>
