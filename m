From: Dinh.Nguyen@freescale.com (Dinh.Nguyen at freescale.com)
Date: Tue, 11 May 2010 13:53:40 -0500
Subject: PATCHv1 0/1 Enable ulpi phy on freescale mx51 babbage hw
Message-ID: <1273604021-857-1-git-send-email-Dinh.Nguyen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch was accidently left out of the original set of patches for
enabling USB Host support on Freescale's MX51 Babbage HW. This patch
brings the USB ULPI PHY on Host1 out of reset, which is required for
enabling Host1 of the hardware.

Thanks,
Dinh Nguyen
