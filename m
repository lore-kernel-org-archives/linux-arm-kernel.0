From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 Sep 2016 21:23:40 +0100
Subject: [PATCH v2 3/8] regulator: axp20x: support AXP806 variant
In-Reply-To: <20160827075544.26316-4-wens@csie.org>
References: <20160827075544.26316-1-wens@csie.org>
 <20160827075544.26316-4-wens@csie.org>
Message-ID: <20160901202340.GT5967@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 27, 2016 at 03:55:39PM +0800, Chen-Yu Tsai wrote:
> The X-Powers AXP806 PMIC has a new set of buck and LDO regulators, and
> also a switch. The buck regulators support teaming into multi-phase
> groups, with A+B, A+B+C, D+E groupings.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160901/e32e5cfe/attachment.sig>
