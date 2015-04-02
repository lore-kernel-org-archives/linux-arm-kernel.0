From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Apr 2015 16:24:08 +0200
Subject: [PATCH 2/6] clocksource: add lpc32xx timer driver
In-Reply-To: <1427923243-26296-3-git-send-email-manabian@gmail.com>
References: <1427923243-26296-1-git-send-email-manabian@gmail.com>
 <1427923243-26296-3-git-send-email-manabian@gmail.com>
Message-ID: <4915355.ihr3xRKEKp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 April 2015 23:20:39 Joachim Eastwood wrote:
> Add support for using the NXP LPC timer as clocksource and
> clock event. These timers are present on many NXP devices
> including LPC32xx, LPC17xx, LPC18xx and LPC43xx.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> 

Would it make sense to change mach-lpc32xx as a follow-up to use
the same driver? It currently hardcodes a driver instead of using
DT.

	Arnd
