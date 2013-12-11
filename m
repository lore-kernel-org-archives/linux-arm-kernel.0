From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Dec 2013 22:21:21 +0100
Subject: [PATCH 0/2] serial: clps711x: UART driver refactor
In-Reply-To: <1386777016-24750-1-git-send-email-shc_work@mail.ru>
References: <1386777016-24750-1-git-send-email-shc_work@mail.ru>
Message-ID: <201312112221.22180.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 December 2013, Alexander Shiyan wrote:
> This is a complex patch for refactoring CLPS711X serial driver.
> Major changes:
> - Eliminate <mach/hardware.h> usage.
> - Devicetree support.
> 
> Patch created for adding in tty tree, but this changes need attention
> from ARM and DT maintainers, so "ACK" will be useful here.

Both patches look good to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>
