From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Nov 2010 14:46:30 -0000
Subject: ARM perf events spin locks
In-Reply-To: <20101130143141.GA2377@n2100.arm.linux.org.uk>
References: <20101130100802.GB4398@pulham.picochip.com>
	<004101cb907b$16f911b0$44eb3510$@deacon@arm.com>
	<20101130105856.GC4398@pulham.picochip.com>
	<004401cb9095$6b1fbcc0$415f3640$@deacon@arm.com>
	<20101130135407.GH4398@pulham.picochip.com>
	<004601cb9096$c3a5d3b0$4af17b10$@deacon@arm.com>
	<20101130143141.GA2377@n2100.arm.linux.org.uk>
Message-ID: <004801cb909d$6010f3a0$2032dae0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I don't mind doing it as a separate patch after Russell has pulled my
> > perf-split branch.
> 
> You mean this?
> 
> commit f1690d17d2c7afa2a2079e3c91eb2bca8c1c5ecd
> Merge: 612275a 43eab87
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Fri Nov 26 10:26:43 2010 +0000
> 
>     Merge branch 'perf-split' of git://linux-arm.org/linux-2.6-wd into devel-stable

Aha, brilliant - thanks.

> Sorry, I didn't push the tree out for a week or so because I was busy with
> other things (like the pgtable stuff.)

There's no rest for the weary! I'll submit the patch to fix perf for sparse
to the patch system (I didn't realise you'd pulled my changes on Friday) and
tackle this spinlock thing at the same time.

Cheers,

Will
