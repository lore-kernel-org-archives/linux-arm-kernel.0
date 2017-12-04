From: tj@kernel.org (Tejun Heo)
Date: Mon, 4 Dec 2017 12:35:52 -0800
Subject: [PATCH 2/2] ahci: mtk: Change driver name to ahci-mtk
In-Reply-To: <20171201104722.17353-1-matthias.bgg@gmail.com>
References: <20171201104722.17353-1-matthias.bgg@gmail.com>
Message-ID: <20171204203552.GI2421075@devbig577.frc2.facebook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 11:47:22AM +0100, Matthias Brugger wrote:
> The driver name "ahci" is already used by the ahci platform driver.
> This leads to the following error:
> Error: Driver 'ahci' is already registered, aborting...
> 
> Change the name to ahci-mtk to fix this.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

Applied to libata/for-4.15-fixes.

Thanks.

-- 
tejun
