From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Oct 2015 09:45:56 +0200
Subject: [PATCH v2] serial: Enable Freescale 16550 workaround on arm
In-Reply-To: <1444257081-30491-1-git-send-email-scottwood@freescale.com>
References: <20151002001616.GA3885@home.buserror.net>
 <1444257081-30491-1-git-send-email-scottwood@freescale.com>
Message-ID: <5847930.GvyTeTDb4p@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 October 2015 17:31:21 Scott Wood wrote:
> The same serial hardware is present on LS2080A which is arm64, and
> LS1021A which is arm32, so don't limit the workaround to PPC.
> 
> Unlike PPC which uses arch/powerpc/kernel/legacy_serial.c, the ARM
> targets use drivers/tty/serial/of_serial.c, so add the handle_irq
> override check there as well.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
