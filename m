From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 14 Nov 2016 10:49:51 +0530
Subject: [PATCH v11 00/14] Add support for FDMA DMA controller and slim
 core rproc found on STi chipsets
In-Reply-To: <1478542665-17089-1-git-send-email-peter.griffin@linaro.org>
References: <1478542665-17089-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <20161114051951.GX3000@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 06:17:31PM +0000, Peter Griffin wrote:
> Hi Vinod and Bjorn,
> 
> This patchset adds support for the Flexible Direct Memory Access (FDMA) core
> found on STi chipsets from STMicroelectronics. The FDMA is a slim core CPU
> with a dedicated firmware. It is a general purpose DMA controller supporting
> 16 independent channels and data can be moved from memory to memory or between
> memory and paced latency critical real time targets.
> 
> In reponse to Bjorn latest mail here https://lkml.org/lkml/2016/11/7/425 and
> here https://patchwork.kernel.org/patch/9368157/ I have created a v11
> incorporating the minor API update, and removed the unrelated change.
> 
> As tthis series has been in linux-next for a while, some additional fixes
> have been submitted and applied by Vinod. I have included these as part of
> the v11 series as well.
> 
> I believe the best route as described here
> https://www.spinics.net/lists/arm-kernel/msg541026.htmlforward is for Vinod
> to apply the whole series on an immutable branch which is then merged into
> both the dma and remoteproc trees.

As I said earlier and just to make it clear, am not taking this one. Please
send updates on top of already applied stuff

-- 
~Vinod
