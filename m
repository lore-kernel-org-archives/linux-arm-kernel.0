From: metan@ucw.cz (Cyril Hrubis)
Date: Tue, 12 Apr 2011 16:43:30 +0200
Subject: reboot/kexec in 2.6.38
In-Reply-To: <m1bp0zylgg.fsf@fess.ebiederm.org>
References: <20110317064523.GA1995@ucw.cz>
	<AANLkTik1CdT4k8SJop7b-MjR27RzF7a=i7WuodNKJi+J@mail.gmail.com>
	<20110322133034.GA15475@atrey.karlin.mff.cuni.cz>
	<m1bp0zylgg.fsf@fess.ebiederm.org>
Message-ID: <20110412144330.GB20815@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> >> I think it's config issue. Never heard of this.
> >
> > I've just compiled and booted 2.6.38. The kernel boots without problems when
> > flashed in. But I've had no success with kexec, the last lines I see are:
> >
> > Starting new kernel
> 
> Enable early_printk to a serial port if you can.
> 
> There is definitely an issue in 2.6.38 where kdump doesn't work, that
> right now looks like a memblock issue.

Finaly got time to solder serial adapter...

And now, after I configured kernel to print to both ttyS0 serial console and
tty0 the kexec started to work.

-- 
metan
