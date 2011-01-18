From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 18 Jan 2011 14:48:54 -0800
Subject: [PATCH] mmc: msm: fix dma usage not to use internal APIs
In-Reply-To: <20110118224159.GO16980@n2100.arm.linux.org.uk>
References: <1295389518-6249-1-git-send-email-dwalker@codeaurora.org>
	<20110118224159.GO16980@n2100.arm.linux.org.uk>
Message-ID: <1295390934.26904.81.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-01-18 at 22:41 +0000, Russell King - ARM Linux wrote:

> +		box->cmd = CMD_MODE_BOX;
> 
> needs to be here.

Yeah, this fixed it.. I'll send out another one.

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
