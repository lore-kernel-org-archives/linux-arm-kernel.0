From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 26 Jan 2015 08:51:08 -0800
Subject: [PATCH] pinctrl: zynq: Fix usb0 pins
In-Reply-To: <1422290895-4046-1-git-send-email-afaerber@suse.de>
References: <1422290895-4046-1-git-send-email-afaerber@suse.de>
Message-ID: <1b0d387535914b48b3a720ecbe143e08@BN1AFFO11FD032.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-01-26 at 05:48PM +0100, Andreas F?rber wrote:
> Fix usb0 pin 19 -> 29 (matching ethernet1 pins and manual).
> Pin 19 is used for ethernet0 on the Parallella board.
> 
> Fixes: add958cee967 ("pinctrl: Add driver for Zynq")
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
Reviewed-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

	Soren
