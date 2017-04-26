From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Wed, 26 Apr 2017 20:51:35 +0000
Subject: [PATCH] ARM: Fix rd_size declaration
In-Reply-To: <20170417231003.7178-1-bart.vanassche@sandisk.com>
References: <20170417231003.7178-1-bart.vanassche@sandisk.com>
Message-ID: <1493239894.2632.15.camel@sandisk.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-04-17 at 16:10 -0700, Bart Van Assche wrote:
> The global variable 'rd_size' is declared as 'int' in source file
> arch/arm/kernel/atags_parse.c and as 'unsigned long' in
> drivers/block/brd.c. Fix this inconsistency.
> [ ... ]

Hello Russell,

Have I sent this patch to the right maintainer?

Thanks,

Bart.
