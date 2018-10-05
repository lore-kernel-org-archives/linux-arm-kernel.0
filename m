From: vkoul@kernel.org (Vinod)
Date: Fri, 5 Oct 2018 20:31:41 +0530
Subject: [PATCH v2 2/3] dmaengine: Add Slave and Cyclic mode support for
 Actions Semi Owl S900 SoC
In-Reply-To: <20180929074637.9766-3-manivannan.sadhasivam@linaro.org>
References: <20180929074637.9766-1-manivannan.sadhasivam@linaro.org>
 <20180929074637.9766-3-manivannan.sadhasivam@linaro.org>
Message-ID: <20181005150141.GN2372@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-09-18, 13:16, Manivannan Sadhasivam wrote:
> Add Slave and Cyclic mode support for Actions Semi Owl S900 SoC. The slave
> mode supports bus width of 4 bytes common for all peripherals and 1 byte
> specific for UART.
> 
> The cyclic mode supports only block mode transfer.

Applied after adding driver tag, thanks
-- 
~Vinod
