From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 18 Oct 2016 20:13:06 +0530
Subject: [RESEND PATCH v10 00/11] Add support for FDMA DMA controller and
 slim core rproc found on STi chipsets
In-Reply-To: <1476783556-2501-1-git-send-email-peter.griffin@linaro.org>
References: <1476783556-2501-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <20161018144306.GX2467@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 10:39:05AM +0100, Peter Griffin wrote:
> Hi Vinod and Bjorn,
> 
> This patchset adds support for the Flexible Direct Memory Access (FDMA) core
> found on STi chipsets from STMicroelectronics. The FDMA is a slim core CPU
> with a dedicated firmware. It is a general purpose DMA controller supporting
> 16 independent channels and data can be moved from memory to memory or between
> memory and paced latency critical real time targets.
> 
> [..]
> 
> V10 series updates remoteproc kconfig subsystem to use 'depends on' rather
> than select for the remoteproc core. Remoteproc client drivers now need to
> 'depends on' for the core part.
> 
> This avoids the Kconfig recursive dependency errors and reliance on the DRM
> patch included with the v9 series. Patches are also included for enabling the
> remoteproc core in the multi_v7 defconfig. All patches for DRM subsystem have
> been removed.
> 
> Note there is no longer a depedency with the DRM_VIRTIO_GPU driver in this series,
> only remoteproc and dmaengine subsystems.

That is a better approach and I have applied this now...

-- 
~Vinod
