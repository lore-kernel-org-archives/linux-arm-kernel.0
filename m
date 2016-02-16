From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 22:22:11 +0100
Subject: [PATCH v4 00/12] Add support for the Armada 3700 SoC an mvebu
 ARM64 based
In-Reply-To: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <2699923.cugyhCaCQy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 19:14:50 Gregory CLEMENT wrote:
> This series introduce the support of the Armada 3700 family: it is the
> first ARM64 SoC of the mvebu family submitted to the mainline!
> 
> Currently there are two members of the Armada 3700 family, the only
> difference is the number of core: the Armada 3710 comes with one
> Cortex-A53 whereas the Armada 3720 comes with 2 Cortex-A53. In this
> series we enabled only the minimum to boot, pinctrl and clock tree
> will come soon.
> 

Whole series

Acked-by: Arnd Bergmann <arnd@arndb.de>
