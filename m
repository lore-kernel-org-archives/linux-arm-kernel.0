From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 8 Oct 2014 19:46:03 +0800
Subject: [PATCH 1/1] ARM: imx_v6_v7_defconfig: enable more USB functions
In-Reply-To: <1412060581-13963-1-git-send-email-peter.chen@freescale.com>
References: <1412060581-13963-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20141008114557.GA3830@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 03:03:01PM +0800, Peter Chen wrote:
> USB Ethernet function at host mode
> USB Media function(webcam) at host mode
> USB Audio function at host mode
> USB Serial function at host mode
> USB EHSET driver at host mode (for OTG & EH Certification test)
> Several USB Gadget functions:
> 	- Configfs
> 	- NCM
> 	- Zero (used for test)
> 	- Gadgetfs
> 	- Serial
> 
> Above functions are built as module.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

Applied, thanks.
