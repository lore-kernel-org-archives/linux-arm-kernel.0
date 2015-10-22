From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 Oct 2015 13:50:08 +0100
Subject: [PATCH 4/6] regulator: axp20x: Support new AXP223 PMIC
In-Reply-To: <1444840342-9233-5-git-send-email-wens@csie.org>
References: <1444840342-9233-1-git-send-email-wens@csie.org>
 <1444840342-9233-5-git-send-email-wens@csie.org>
Message-ID: <20151022125008.GJ8232@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 12:32:20AM +0800, Chen-Yu Tsai wrote:
> The AXP223 is a new PMIC commonly paired with Allwinner A23/A33 SoCs.
> It is functionally identical to AXP221; only the regulator default
> voltage/status and the external host interface are different.

Reviwed-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151022/4177eab1/attachment.sig>
