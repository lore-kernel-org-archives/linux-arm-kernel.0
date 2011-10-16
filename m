From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 20:15:48 +0200
Subject: [PATCH 0/4] ARM: at91 rename at91 ref boards defconfig as soc
	defconfig
Message-ID: <20111016181548.GH1459@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	this patch series rename the Amtel reference board defconfig as soc
	config and enable all the boards in it

	This will allow when compiling (just a few of them) to check that we
	break no boards

	This patch series will not remove the boards specifc defconfig

Best Regards,
J.
