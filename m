From: marex@denx.de (Marek Vasut)
Date: Thu, 4 Jun 2015 00:58:52 +0200
Subject: [PATCH 04/11] mtd: ofpart: do not fail probe when no partitions
 exist
In-Reply-To: <36e315552c849a4d22ac0fcff7958f6ffcafb160.1433364398.git.hramrach@gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
 <36e315552c849a4d22ac0fcff7958f6ffcafb160.1433364398.git.hramrach@gmail.com>
Message-ID: <201506040058.52882.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 03, 2015 at 11:26:40 PM, Michal Suchanek wrote:
> On Exynos it is necessary to set SPI controller parameters that apply to
> a SPI slave in a DT subnode of the slave device. The ofpart code returns
> an error when there are subnodes of the SPI flash but no partitions are
> found. Change this condition to a warning so that flash without
> partitions can be accessed on Exynos.

I have to admit the rationale for this patch is not very clear to me, sorry.
Can you please explain this a bit more ?

Best regards,
Marek Vasut
