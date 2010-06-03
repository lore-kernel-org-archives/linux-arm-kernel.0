From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 3 Jun 2010 21:55:19 +0200
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <20100603192459.GA9169@n2100.arm.linux.org.uk>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
Message-ID: <201006032155.19349.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 3. ?ervna 2010 21:24:59 Russell King - ARM Linux napsal(a):
> The subject says everything you need to know.  Randy provided this
> link earlier:
> 
>   http://lkml.org/lkml/2010/6/2/472
> 
> Linus doesn't appear to be listening to reason, so I see now this as
> a fait accompli.  It'll apparantly happen at the next merge window.

The defconfigs age ... there's no point keeping them. They'll be useless crap 
unless someone updates them often anyway.

Maybe adding a Kconfig option that's select all the default stuff the platform 
needs would be a way to go ? (that was already proposed there)

> 
> So, don't send anything which contains a defconfig file or updates to
> it.  It's pointless.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
