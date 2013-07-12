From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 12 Jul 2013 18:07:04 +0530
Subject: [PATCH] arm: omap5: dts: fix reg property size
In-Reply-To: <1373630285-17389-1-git-send-email-balbi@ti.com>
References: <1373630285-17389-1-git-send-email-balbi@ti.com>
Message-ID: <51DFF870.5060507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 July 2013 05:28 PM, Felipe Balbi wrote:
> USB3 block has a 64KiB space, another 64KiB is
> used for the wrapper.
> 
> Without this change, resource_size() will get
> confused and driver won't probe because size
> will be negative.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> does anybody know Benoit's knew email address ?
benoit.cousson at linaro.org

-Kishon
