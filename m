From: tsoni@codeaurora.org (Trilok Soni)
Date: Tue, 01 Mar 2011 12:45:30 +0530
Subject: [PATCH v2 2/4] msm: iommu: Rework clock logic and add IOMMU bus
	clock control
In-Reply-To: <1298937782-28725-1-git-send-email-stepanm@codeaurora.org>
References: <1298599242-21971-2-git-send-email-stepanm@codeaurora.org>
	<1298937782-28725-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <4D6C9D12.8090207@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On 3/1/2011 5:33 AM, Stepan Moskovchenko wrote:
> Clean up the clock control code in the probe calls, and add
> support for controlling the clock for the IOMMU bus
> interconnect. With the (proper) clock driver in place, the
> clock control logic in the probe function can be made much
> cleaner since it does not have to deal with the placeholder
> driver anymore.
> 
> Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
> ---
> v2: Use resource_size.

Looks good to me.

Reviewed-by: Trilok Soni <tsoni@codeaurora.org>

---Trilok Soni
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
