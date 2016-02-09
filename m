From: davem@davemloft.net (David Miller)
Date: Tue, 09 Feb 2016 04:52:14 -0500 (EST)
Subject: [PATCH 0/4] Add Ethernet support on STM32F429
In-Reply-To: <1454511275-9791-1-git-send-email-alexandre.torgue@gmail.com>
References: <1454511275-9791-1-git-send-email-alexandre.torgue@gmail.com>
Message-ID: <20160209.045214.805916119264070573.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre TORGUE <alexandre.torgue@gmail.com>
Date: Wed,  3 Feb 2016 15:54:31 +0100

> STM32F429 Chip embeds a Synopsys 3.50a MAC IP.
> This series:
> 	-enhance current stmmac driver to control it (code already available) and 
> 	 adds basic glue for STM32F429 chip.
> 	-Enable basic Net config in kernel.
> 
> Note that DT patches are not present because STM32 pinctrl code is not
> yet avalaible.

Looks like this needs to be respun to deal with the warnings the kbuild
robot reported.

Thanks.
