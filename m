From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 22 Jan 2012 12:12:30 +0100
Subject: [RFC PATCH 00/11] Cortex-M3 support
Message-ID: <20120122111230.GB14835@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series is mostly a port of patches done by Catalin Marinas for
2.6.33. It's based on 3.3-rc1. There are still a few rough edges and I'm
sure I'm not aware of all of them as this deep architecture stuff is
mostly news for me. Some things are noted in the respective patches, I'm
sure you can find more.

My target machine is the EFM32 Giant Gecko by Energy Micro and my
complete tree can be found at

	git://git.pengutronix.de/git/ukl/linux.git efm32

(with a gitweb being available at

	http://git.pengutronix.de/?p=ukl/linux.git;a=shortlog;h=efm32

).

I look forward to your comments.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
