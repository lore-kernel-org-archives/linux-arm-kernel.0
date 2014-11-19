From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 19 Nov 2014 21:12:23 +0100
Subject: [PATCH 2/6] arm: pxa: specify PMUs are for XScale CPUs
In-Reply-To: <1416397800-12457-3-git-send-email-mark.rutland@arm.com> (Mark
 Rutland's message of "Wed, 19 Nov 2014 11:49:56 +0000")
References: <1416397800-12457-1-git-send-email-mark.rutland@arm.com>
 <1416397800-12457-3-git-send-email-mark.rutland@arm.com>
Message-ID: <87ioib6jbs.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland <mark.rutland@arm.com> writes:

> Now that we can specify which PMU variant we're likely to deal with, do
> so in the pxa board code. This will allow us to split the ARMv6, ARMv7,
> and XScale PMU drivers.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert
