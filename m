From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 06 Jun 2016 12:25:36 +0200
Subject: [PATCH 0/4] serial: earlycon: keep earlycon symbols for
 non-module and driver clean-ups
In-Reply-To: <1465206063-1018-1-git-send-email-yamada.masahiro@socionext.com>
References: <1465206063-1018-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <3280512.PAaBGkzban@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 6, 2016 6:40:59 PM CEST Masahiro Yamada wrote:
> 1/4: keep earlycon symbols only when CONFIG_SERIAL_EARLYCON is defined
>      and the driver is built-in.
> 
> 2/4 thru 4/4: driver clean-ups.
>               (partially reverts build fixes by Arnd Bergmann)
> 
> 
> 


Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
