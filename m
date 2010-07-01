From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 1 Jul 2010 14:07:25 +0100
Subject: [PATCH 29/33] Removing dead SND_SOC_SMDK2443_WM9710
In-Reply-To: <AANLkTinZa7_TEjYFTu9V6obndpVvMmHppaOArM1AJg_t@mail.gmail.com>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<e5391de6858597bbfd43874aed124a73f74850b5.1277911346.git.siccegge@cs.fau.de>
	<AANLkTinZa7_TEjYFTu9V6obndpVvMmHppaOArM1AJg_t@mail.gmail.com>
Message-ID: <20100701130724.GC17698@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 01, 2010 at 09:55:47PM +0900, Jassi Brar wrote:
> On Thu, Jul 1, 2010 at 1:03 AM, Christoph Egger <siccegge@cs.fau.de> wrote:
> > SND_SOC_SMDK2443_WM9710 doesn't exist in Kconfig, therefore removing
> > all references for it from the source code.

> I'd rather have the code compiled unconditionally.

Hrm, if this is part of the default hardware build we should get the
driver merged.
