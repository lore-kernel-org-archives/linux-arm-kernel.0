From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 4 Apr 2018 11:49:59 +0530
Subject: [PATCH v1 0/8] Append several fixes and improvements in STM32 DMA
In-Reply-To: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
References: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20180404061958.GH15443@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 05:41:59PM +0100, Pierre-Yves MORDRET wrote:
> This patchset appends several fixes and some improvements for STM32 DMAv2.
> This includes:
>         * Introduce DMA features bitfield
>         * Threshold manages with bitfield feature
>         * Improve memory burst management
>         * Improve DMA IRQ status handling
>         * Fix max items per transfer to match FIFO Size
>         * Properly mask irq bits to avoid overlaping
>         * Fix incomplete configuration in cyclic mode
>         * Fix typo and reported checkpatch warnings

Applied, thanks

-- 
~Vinod
