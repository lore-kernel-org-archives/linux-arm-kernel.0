From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Jul 2011 17:09:40 +0200
Subject: AT91: Fix pull requset
In-Reply-To: <20110701065411.GD14408@game.jcrosoft.org>
References: <20110701065411.GD14408@game.jcrosoft.org>
Message-ID: <201107011709.40359.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 July 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> HI Linus, Russell, Arnd
> 
> 	I do not known who can take this pull request
> 
> 	But this is some fix for at91 for the 3.0

I can take and forward these next week, possibly together with other bug
fixes that come in for soc trees.

One comment though:

> Jean-Christophe PLAGNIOL-VILLARD (3):
>       at91: fix at91_set_serial_console: use platform device id
>       atmel_serial: fix internal port num

These two patches look like they should apply to older kernels as well:
The code you change has been in the kernel since 2006.

For every bug fix you commit, please check if it applies to older
kernels as well, and mark with 'Cc: stable at kernel.org' if so. Do you
want to update the changelog and send another pull request?

	Arnd
