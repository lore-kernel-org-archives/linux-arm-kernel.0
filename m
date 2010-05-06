From: rk.raggit@gmail.com (RK Raggit)
Date: Thu, 6 May 2010 21:50:07 +0530
Subject: cortex-m3 booting failure
In-Reply-To: <1273153908.2094.5.camel@e102109-lin.cambridge.arm.com>
References: <h2zec1f3d401005060330n22178e21ve22265bd37006825@mail.gmail.com>
	<1273153908.2094.5.camel@e102109-lin.cambridge.arm.com>
Message-ID: <t2qec1f3d401005060920u5db391bg455961b30d2c1a26@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I can't really tell what's happening but I'm going to release a new set
> of patches against 2.6.33 sometime next week and there are some improved
> error messages for Cortex-M3 support.
>

Great. That should help !

> Do you have KALLSYMS enabled in the kernel?
>
I will check (i am away from office right now)


>
> Have you tried with my variant of busybox from the above link?
>
Yes i did , with the same results .

> Are you using the uclinux-eabi variant of the toolchain? Do you specify
> -march=armv7-m and -mthumb options? If you link against the wrong C
> library, it will fail.
>

Yes i use that variant with those options. When i try "init=/bin/ls" or
"init=/bin/busybox" or "init=/bin/date" i can see correct output. Based on this
i feel the binaries are correctly built.

--RK
