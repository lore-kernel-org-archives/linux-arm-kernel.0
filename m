From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 22 Sep 2009 08:26:12 -0700
Subject: [PATCH] ARM: includecheck fix: mach-davinci, board-dm365-evm.c
In-Reply-To: <1253624821.3784.8.camel@ht.satnam> (Jaswinder Singh Rajput's
	message of "Tue\, 22 Sep 2009 18\:37\:01 +0530")
References: <1253624821.3784.8.camel@ht.satnam>
Message-ID: <87k4zrdmqz.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jaswinder Singh Rajput <jaswinder@kernel.org> writes:

> fix the following 'make includecheck' warning:
>
>   arch/arm/mach-davinci/board-dm365-evm.c: mach/common.h is included more than once.
>
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
