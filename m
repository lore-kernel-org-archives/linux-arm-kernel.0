From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 18 Feb 2011 10:46:11 -0800
Subject: [PATCH] msm: add single-wire serial bus interface (SSBI) driver
In-Reply-To: <4D5DC289.1090004@codeaurora.org>
References: <1297989299-27320-1-git-send-email-kheitke@codeaurora.org>
	<1297989432.9680.50.camel@c-dwalke-linux.qualcomm.com>
	<4D5DC289.1090004@codeaurora.org>
Message-ID: <1298054771.17758.1.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-02-17 at 16:51 -0800, Bryan Huntsman wrote:
> On 02/17/2011 04:37 PM, Daniel Walker wrote:
> > Can you put this in drivers/ this doesn't looks like it need to be here.
> 
> Where would you suggest?  The initial attempt to model SSBI as an I2C
> bus didn't go anywhere.  See http://lkml.org/lkml/2010/7/21/400.  This
> functionality is specific to MSM.  Plus, we're trying to maintain
> similarity to the Android MSM tree.  That may not matter to people who
> don't use MSM, but is matters to us.  Given these considerations, the
> current location seems as good a place as any.

I don't know the driver well enough to be more detailed than suggesting
drivers/ . In the thread you quoted Pavel (who I added to the CC line)
suggested drivers/ssbi/ .

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
