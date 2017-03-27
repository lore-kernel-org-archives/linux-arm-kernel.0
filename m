From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 27 Mar 2017 10:04:08 +0530
Subject: [PATCH v8 2/3] dmaengine: pl330: remove pdata based initialization
In-Reply-To: <f0d36362-ce75-02a0-0bfa-e265cba03b8b@samsung.com>
References: <1486650171-20598-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170209142308eucas1p24d52db3d52e19228e8f423c3dc8b085b@eucas1p2.samsung.com>
 <1486650171-20598-3-git-send-email-m.szyprowski@samsung.com>
 <f0d36362-ce75-02a0-0bfa-e265cba03b8b@samsung.com>
Message-ID: <20170327043408.GC9308@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 09:22:23AM +0100, Marek Szyprowski wrote:
> Hi Vinod
> 
> 
> On 2017-02-09 15:22, Marek Szyprowski wrote:
> >This driver is now used only on platforms which support device tree, so
> >it is safe to remove legacy platform data based initialization code.
> >
> >Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >Acked-by: Arnd Bergmann <arnd@arndb.de>
> >For plat-samsung:
> >Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Vinod: This patch is completely independent from the rest of the changes
> from that patchset. Could you apply it, or do you want me to resend it
> separately? Runtime pm related changes will wait until a new DMA engine API
> is ready.

Sure, please resend it :)

-- 
~Vinod
