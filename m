From: agross@codeaurora.org (Andy Gross)
Date: Thu, 20 Mar 2014 00:04:37 -0500
Subject: [PATCH v5 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
In-Reply-To: <1394762863-12154-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1394762863-12154-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1394762863-12154-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20140320050437.GA29449@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 07:07:43PM -0700, Bjorn Andersson wrote:
> This bus driver supports the QUP i2c hardware controller in the Qualcomm SOCs.
> The Qualcomm Universal Peripheral Engine (QUP) is a general purpose data path
> engine with input/output FIFOs and an embedded i2c mini-core. The driver
> supports FIFO mode (for low bandwidth applications) and block mode (interrupt
> generated for each block-size data transfer).
> 

<snip>


Looks good.

Reviewed-by: Andy Gross <agross@codeaurora.org>

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
