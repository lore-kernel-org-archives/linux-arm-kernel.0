From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Oct 2012 15:05:25 +0100
Subject: [git pull] signals pile 3
In-Reply-To: <20121016140414.GS639@pengutronix.de>
References: <20121013005334.GM2616@ZenIV.linux.org.uk>
 <507ADBBB.9090209@gmail.com> <20121014202431.GL21164@n2100.arm.linux.org.uk>
 <20121014222449.GN21164@n2100.arm.linux.org.uk> <507B3F2C.1090500@gmail.com>
 <20121014231649.GO21164@n2100.arm.linux.org.uk>
 <20121016140414.GS639@pengutronix.de>
Message-ID: <20121016140525.GG21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 04:04:14PM +0200, Uwe Kleine-K?nig wrote:
> I used:
>  	movne	r0, r4
> -	movne	lr, pc
> -	movne	pc, r5
> +	blxne	r5
>  	get_thread_info tsk
> 
> but I assume Russell's patch is better. (Probably because blx doesn't
> exist everywhere?!)

Correct.

> So if it's not too late yet:
> 
> Tested-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

It is, because it's already in Linus' tree.
