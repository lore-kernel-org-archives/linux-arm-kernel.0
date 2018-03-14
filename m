From: edubezval@gmail.com (Eduardo Valentin)
Date: Wed, 14 Mar 2018 16:42:31 -0700
Subject: [PATCH 00/12] thermal: exynos: sanitize DeviceTree support
In-Reply-To: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20180306144427epcas1p3bd260e382c61ab5176a50aa95084b542@epcas1p3.samsung.com>
 <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20180314234230.GA9784@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Mar 06, 2018 at 03:43:43PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> Values passed through DT properties specific to Exynos thermal
> driver ("samsung,*") are SoC (not platform) specific so just
> define them in struct exynos_tmu_data instance (or just use
> constants where values are identical for all SoCs) and remove
> "samsung," DT properties altogether.
> 
> The patchset should not cause any functionality changes.  This
> means that unless there are some bugs in the patches itself there
> should be no behavior changes for the driver (this also includes
> lack of changes in the way hardware is accessed by the driver).
> 
> Tested on Exynos5422 based Odroid-XU3 Lite board.

applied this series. except for patch 10, which should go through your
arch tree.

Thanks.

> 1.9.1
