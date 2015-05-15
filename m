From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 22:01:49 +0200
Subject: [PATCH v4 2/7] clocksource: add lpc32xx timer driver
In-Reply-To: <1431381653-25356-3-git-send-email-manabian@gmail.com>
References: <1431381653-25356-1-git-send-email-manabian@gmail.com>
 <1431381653-25356-3-git-send-email-manabian@gmail.com>
Message-ID: <2239410.eaKNvGFUP4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 May 2015 00:00:48 Joachim Eastwood wrote:
> Add support for using the NXP LPC timer as clocksource and clock
> event. These timers are present on many NXP devices including
> LPC32xx, LPC17xx, LPC18xx and LPC43xx.
> 
> The timer has a 32-bit timer counter register with a programmable
> 32-bit prescaler. It supports up to 4 compare match values with
> interrupt generation and reset/stop timer counter action.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> 

Looks ok to me, please merge this and patch 3 through the clocksource tree.

	Arnd
