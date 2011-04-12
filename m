From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 12 Apr 2011 22:46:25 +0800
Subject: reboot/kexec in 2.6.38
In-Reply-To: <20110412144330.GB20815@atrey.karlin.mff.cuni.cz>
References: <20110317064523.GA1995@ucw.cz>
	<AANLkTik1CdT4k8SJop7b-MjR27RzF7a=i7WuodNKJi+J@mail.gmail.com>
	<20110322133034.GA15475@atrey.karlin.mff.cuni.cz>
	<m1bp0zylgg.fsf@fess.ebiederm.org>
	<20110412144330.GB20815@atrey.karlin.mff.cuni.cz>
Message-ID: <BANLkTikZXjfD82DxoahkvUo+26cjvOKZmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2011 at 10:43 PM, Cyril Hrubis <metan@ucw.cz> wrote:
> Hi!
>> >> I think it's config issue. Never heard of this.
>> >
>> > I've just compiled and booted 2.6.38. The kernel boots without problems when
>> > flashed in. But I've had no success with kexec, the last lines I see are:
>> >
>> > Starting new kernel
>>
>> Enable early_printk to a serial port if you can.
>>
>> There is definitely an issue in 2.6.38 where kdump doesn't work, that
>> right now looks like a memblock issue.
>
> Finaly got time to solder serial adapter...
>
> And now, after I configured kernel to print to both ttyS0 serial console and
> tty0 the kexec started to work.

Cool. Please help check why it didn't work, and see if we have something
broken.

>
> --
> metan
>
