From: davidb@codeaurora.org (David Brown)
Date: Mon, 29 Jul 2013 10:43:46 -0700
Subject: [PATCH v2 1/6] usb: phy: msm: Move mach depndend code to
 platform data
In-Reply-To: <1375081464-14206-2-git-send-email-iivanov@mm-sol.com>
References: <1375081464-14206-1-git-send-email-iivanov@mm-sol.com>
 <1375081464-14206-2-git-send-email-iivanov@mm-sol.com>
Message-ID: <20130729174346.GA16352@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 10:04:19AM +0300, Ivan T. Ivanov wrote:
>From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
>
>This patch fix compilation error and is an intermediate step
>before the addition of DeviceTree support for newer targets.
>Fix suggested here: https://lkml.org/lkml/2013/6/19/381
>
>Cc: David Brown <davidb@codeaurora.org>
>Cc: Daniel Walker <dwalker@fifo99.com>
>Cc: Bryan Huntsman <bryanh@codeaurora.org>
>Cc: Felipe Balbi <balbi@ti.com>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: linux-arm-kernel at lists.infradead.org
>Cc: linux-kernel at vger.kernel.org
>Cc: linux-usb at vger.kernel.org
>
>Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
>---
> arch/arm/mach-msm/board-msm7x30.c |   35 +++++++++++++++++++++++
> arch/arm/mach-msm/board-qsd8x50.c |   35 +++++++++++++++++++++++

Acked-by: David Brown <davidb@codeaurora.org>

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
