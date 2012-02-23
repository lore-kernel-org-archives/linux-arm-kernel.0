From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Feb 2012 12:49:16 +0000
Subject: [PATCH v2 1/2] GPIO: LPC32xx: Fix missing bit selection mask
In-Reply-To: <1329845828-26497-1-git-send-email-stigge@antcom.de>
References: <1329845828-26497-1-git-send-email-stigge@antcom.de>
Message-ID: <201202231249.17206.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 February 2012, Roland Stigge wrote:
> Add missing mask to pin bit selection in gpio-lpc32xx.c
> (#define GPIO3_PIN_IN_SEL)
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Sorry I picked on the old thread first.

Acked-by: Arnd Bergmann <arnd@arndb.de>
