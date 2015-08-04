From: agross@codeaurora.org (Andy Gross)
Date: Tue, 4 Aug 2015 13:48:22 -0500
Subject: [PATCH 02/18] firmware: qcom_scm-32: replace open-coded call to
 __cpuc_flush_dcache_area()
In-Reply-To: <E1ZJhWZ-00043Z-Ft@rmk-PC.arm.linux.org.uk>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
 <E1ZJhWZ-00043Z-Ft@rmk-PC.arm.linux.org.uk>
Message-ID: <20150804184822.GA10826@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 01:28:55PM +0100, Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

Acked-by: Andy Gross <agross@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
