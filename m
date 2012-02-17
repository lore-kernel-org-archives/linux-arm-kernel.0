From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 17 Feb 2012 13:38:57 -0800
Subject: [PATCH 1/2] ARM: U300: Don't specify regulator consumers by
 struct device
In-Reply-To: <1329449029.17110.1.camel@phoenix>
References: <1329449029.17110.1.camel@phoenix>
Message-ID: <20120217213856.GA21717@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2012 at 11:23:49AM +0800, Axel Lin wrote:
> The dev field is remove from struct regulator_consumer_supply since commit
> 737f36 "regulator: Remove support for supplies specified by struct device".

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120217/5b548ca0/attachment.sig>
