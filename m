From: bryanh@codeaurora.org (Bryan Huntsman)
Date: Thu, 17 Feb 2011 16:51:21 -0800
Subject: [PATCH] msm: add single-wire serial bus interface (SSBI) driver
In-Reply-To: <1297989432.9680.50.camel@c-dwalke-linux.qualcomm.com>
References: <1297989299-27320-1-git-send-email-kheitke@codeaurora.org>
	<1297989432.9680.50.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <4D5DC289.1090004@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/17/2011 04:37 PM, Daniel Walker wrote:
> Can you put this in drivers/ this doesn't looks like it need to be here.

Where would you suggest?  The initial attempt to model SSBI as an I2C
bus didn't go anywhere.  See http://lkml.org/lkml/2010/7/21/400.  This
functionality is specific to MSM.  Plus, we're trying to maintain
similarity to the Android MSM tree.  That may not matter to people who
don't use MSM, but is matters to us.  Given these considerations, the
current location seems as good a place as any.

- Bryan

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
