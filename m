From: vkoul@infradead.org (Vinod Koul)
Date: Mon, 28 Jan 2013 01:46:45 -0800
Subject: [PATCH v2] DMAEngine: sirf: add DMA pause/resume support
In-Reply-To: <1355482762-28688-1-git-send-email-Barry.Song@csr.com>
References: <1355482762-28688-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1359366405.8789.3180.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-12-14 at 18:59 +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> pause/resume are important for users like ALSA sound drivers,
> this patches make the sirf prima2/marco support DMA commands
> DMA_PAUSE and DMA_RESUME.
Applied this and sirf: lock the shared registers access in
sirfsoc_dma_terminate_all, thanks


-- 
Vinod Koul
Intel Corp.
