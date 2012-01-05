From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 5 Jan 2012 17:14:36 +0800
Subject: [PATCH v3 1/2] dma/imx-sdma: let sdma_run_channel call
 sdma_enable_channel
In-Reply-To: <1325750362-22598-2-git-send-email-richard.zhao@linaro.org>
References: <1325750362-22598-1-git-send-email-richard.zhao@linaro.org>
 <1325750362-22598-2-git-send-email-richard.zhao@linaro.org>
Message-ID: <20120105091434.GA1729@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 03:59:21PM +0800, Richard Zhao wrote:
> Let all enable channel code call sdma_enable_channel.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
