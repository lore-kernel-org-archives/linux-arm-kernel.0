From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 21 Oct 2013 12:56:45 +0530
Subject: [PATCH 3/3] dma: edma: Increase maximum SG limit to 20
In-Reply-To: <1379977515-3794-4-git-send-email-joelf@ti.com>
References: <1379977515-3794-1-git-send-email-joelf@ti.com>
 <1379977515-3794-4-git-send-email-joelf@ti.com>
Message-ID: <20131021072645.GO14013@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 06:05:15PM -0500, Joel Fernandes wrote:
> davinci-pcm uses 16 as the no.of periods. With this, in EDMA we have to
> allocate atleast 17 slots: 1 slot for channel, and 16 slots the periods.
> 
> Due to this, the MAX_NR_SG limitation causes problems, set it to 20 to make
> cyclic DMA work when davinci-pcm is converted to use DMA Engine. Also add
> a comment clarifying this.

Applied, thanks

--
~Vinod
