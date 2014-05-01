From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 1 May 2014 10:26:00 -0400 (EDT)
Subject: [PATCH v2 1/4] usb: ohci-exynos: Use struct device instead of
 platform_device
In-Reply-To: <1398835192-21634-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <Pine.LNX.4.44L0.1405011025260.1152-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Apr 2014, Vivek Gautam wrote:

> Change to use struct device instead of struct platform_device
> for some static functions.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> ---

For all four patches in this series:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
