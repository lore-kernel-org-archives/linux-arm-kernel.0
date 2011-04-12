From: metan@ucw.cz (Cyril Hrubis)
Date: Tue, 12 Apr 2011 20:13:05 +0200
Subject: reboot/kexec in 2.6.38
In-Reply-To: <BANLkTikZXjfD82DxoahkvUo+26cjvOKZmw@mail.gmail.com>
References: <20110317064523.GA1995@ucw.cz>
	<AANLkTik1CdT4k8SJop7b-MjR27RzF7a=i7WuodNKJi+J@mail.gmail.com>
	<20110322133034.GA15475@atrey.karlin.mff.cuni.cz>
	<m1bp0zylgg.fsf@fess.ebiederm.org>
	<20110412144330.GB20815@atrey.karlin.mff.cuni.cz>
	<BANLkTikZXjfD82DxoahkvUo+26cjvOKZmw@mail.gmail.com>
Message-ID: <20110412181305.GB2665@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> >> Enable early_printk to a serial port if you can.
> >>
> >> There is definitely an issue in 2.6.38 where kdump doesn't work, that
> >> right now looks like a memblock issue.
> >
> > Finaly got time to solder serial adapter...
> >
> > And now, after I configured kernel to print to both ttyS0 serial console and
> > tty0 the kexec started to work.
> 
> Cool. Please help check why it didn't work, and see if we have something
> broken.

Hmm, It seems to work now (I've changed the config slightly meanwhile and now
I've been unable to trigger the bug).

Note to myself: save configs that trigger strange behavior.

-- 
metan
