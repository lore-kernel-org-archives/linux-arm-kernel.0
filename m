From: davidb@codeaurora.org (David Brown)
Date: Fri, 5 Aug 2011 13:36:29 -0700
Subject: [PATCH 1/2] arm/mx5: parse iomuxc pad configuratoin from device
	tree
In-Reply-To: <4E3C51F5.50707@freescale.com>
References: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>
	<1311606467-28985-2-git-send-email-shawn.guo@linaro.org>
	<20110725204630.GD26735@ponder.secretlab.ca>
	<CAKGA1bmbWUeyhUtDwHZjB8V4e2wJ0NHX2qWhqaqx6HoBm7uMnQ@mail.gmail.com>
	<4E3C51F5.50707@freescale.com>
Message-ID: <20110805203629.GB6991@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2011 at 03:26:29PM -0500, Scott Wood wrote:

> > Yes, it puts the onus of the work on the firmware guys, but they're
> > the ones writing the device trees for their hardware anyway.
> 
> Sometimes.

I'm not even sure that is going to be common.  At least our setup is
going to have the device tree living in flash somewhere.  The
bootloader only knows enough about the FDT to insert arguments and
memory information into it.  They certainly aren't the appropriate
team to be defining the device tree.

David


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
