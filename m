From: paul.chavent@fnac.net (Paul Chavent)
Date: Thu, 02 Sep 2010 22:46:47 +0200
Subject: [PATCH] arm mach-at91 use choice keyword for board type selection
	in Kconfig
Message-ID: <4C800D37.6080703@fnac.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems that we can select more than one board for one kernel.

This patch use a choice keyword for board type selection in Kconfig.


Signed-off-by: Paul Chavent <paul.chavent@fnac.net>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: linux-2.6.35.4-arm_at91_board_choice.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100902/c023fe71/attachment.ksh>
