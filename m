From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 28 Mar 2017 21:38:37 +0530
Subject: [PATCH RESEND] dmaengine: pl330: remove pdata based initialization
In-Reply-To: <1490592663-19666-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170327053114eucas1p2f87c67ff869181cd288a99ceff9c7e1c@eucas1p2.samsung.com>
 <1490592663-19666-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170328160837.GS9308@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 07:31:03AM +0200, Marek Szyprowski wrote:
> This driver is now used only on platforms which support device tree, so
> it is safe to remove legacy platform data based initialization code.

Applied, thanks

-- 
~Vinod
