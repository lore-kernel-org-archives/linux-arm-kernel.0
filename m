From: davidb@codeaurora.org (David Brown)
Date: Wed, 24 Jul 2013 08:55:05 -0700
Subject: [PATCH 1/7] usb: phy: msm: Move mach dependent code to platform
 data
In-Reply-To: <1372087664-26396-2-git-send-email-iivanov@mm-sol.com>
References: <1372087664-26396-1-git-send-email-iivanov@mm-sol.com>
 <1372087664-26396-2-git-send-email-iivanov@mm-sol.com>
Message-ID: <20130724155505.GA26371@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 06:27:38PM +0300, Ivan T. Ivanov wrote:
>From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
>
>This patch fix compilation error and is an intermediate step
>before the addition of DeviceTree support for newer targets.
>Fix suggested here: https://lkml.org/lkml/2013/6/19/381
>
>Cc: David Brown <davidb@codeaurora.org>
>Cc: Daniel Walker <dwalker@fifo99.com>
>Cc: Bryan Huntsman <bryanh@codeaurora.org>
>Cc: Russell King <linux@arm.linux.org.uk>
>Cc: Felipe Balbi <balbi@ti.com>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: Stephen Boyd <sboyd@codeaurora.org>
>Cc: linux-arm-kernel at lists.infradead.org
>Cc: linux-kernel at vger.kernel.org
>
>Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
>---
> arch/arm/mach-msm/board-msm7x30.c |   35 +++++++++++++++++++++++
> arch/arm/mach-msm/board-qsd8x50.c |   34 +++++++++++++++++++++++
> drivers/usb/phy/phy-msm-usb.c     |   55 ++++++++++---------------------------
> include/linux/usb/msm_hsusb.h     |    2 ++
> 4 files changed, 85 insertions(+), 41 deletions(-)

Acked-by: David Brown <davidb@codeaurora.org>

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
