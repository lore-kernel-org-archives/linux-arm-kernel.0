From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 3 Sep 2010 00:40:41 +0200
Subject: [PATCH] arm mach-at91 use choice keyword for board type
	selection in Kconfig
In-Reply-To: <4C800D37.6080703@fnac.net>
References: <4C800D37.6080703@fnac.net>
Message-ID: <20100902224041.GB21449@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:46 Thu 02 Sep     , Paul Chavent wrote:
> It seems that we can select more than one board for one kernel.
> 
> This patch use a choice keyword for board type selection in Kconfig.
NACK

we do want to be able to compile mutliple board in the same kernel
and select it at runtime by the bootloader

Best Regards,
J.
