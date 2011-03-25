From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 25 Mar 2011 13:49:35 -0700
Subject: reboot/kexec in 2.6.38
In-Reply-To: <20110322133034.GA15475@atrey.karlin.mff.cuni.cz> (Cyril Hrubis's
	message of "Tue, 22 Mar 2011 14:30:34 +0100")
References: <20110317064523.GA1995@ucw.cz>
	<AANLkTik1CdT4k8SJop7b-MjR27RzF7a=i7WuodNKJi+J@mail.gmail.com>
	<20110322133034.GA15475@atrey.karlin.mff.cuni.cz>
Message-ID: <m1bp0zylgg.fsf@fess.ebiederm.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cyril Hrubis <metan@ucw.cz> writes:

> Hi!
>> I think it's config issue. Never heard of this.
>
> I've just compiled and booted 2.6.38. The kernel boots without problems when
> flashed in. But I've had no success with kexec, the last lines I see are:
>
> Starting new kernel

Enable early_printk to a serial port if you can.

There is definitely an issue in 2.6.38 where kdump doesn't work, that
right now looks like a memblock issue.

Eric
