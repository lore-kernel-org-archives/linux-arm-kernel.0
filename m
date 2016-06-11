From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 11 Jun 2016 11:43:54 +0200 (CEST)
Subject: [PATCH 44/48] clocksource: atmel-pit: allow unselecting ATMEL_PIT
In-Reply-To: <1465596231-21766-45-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1465596231-21766-45-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <alpine.DEB.2.11.1606111143330.5839@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 11 Jun 2016, Alexandre Belloni wrote:

> With the new TCB clocksource driver, atmel platforms are now able to boot
> without the PIT driver. Allow unselecting it.

Yay! Thanks for doing this!

     tglx

 
