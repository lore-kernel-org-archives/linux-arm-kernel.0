From: jp.francois@cynove.com (jean-philippe francois)
Date: Fri, 9 Mar 2012 08:34:44 +0100
Subject: Regression in 3.2.9 for omap-serial (at least)
In-Reply-To: <alpine.LFD.2.02.1203082024450.2742@ionos>
References: <lyk42vxsz2.fsf@ensc-virt.intern.sigma-chemnitz.de>
 <alpine.LFD.2.02.1203081246130.2742@ionos>
 <CAGGh5h3-1XhMO1-jiBdUJYgh4unRcPonvp=zcXLKMJBfS+qpuQ@mail.gmail.com>
 <alpine.LFD.2.02.1203082024450.2742@ionos>
Message-ID: <CAGGh5h0sC1mYFpDj973Xgbh7CQ3eGZEYVTy8qZwbsPBA_z4MRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 8 mars 2012 20:26, Thomas Gleixner <tglx@linutronix.de> a ?crit :
> On Thu, 8 Mar 2012, jean-philippe francois wrote:
>
>> Le 8 mars 2012 12:46, Thomas Gleixner <tglx@linutronix.de> a ?crit :
>> > On Thu, 8 Mar 2012, Enrico Scholz wrote:
>> >> Hi,
>> >>
>> >> the commit "genirq: Unmask oneshot irqs when thread was not woken"[1]
>> >> breaks at least the omap-serial driver which requests a shared interrupt
>> >
>> > Fixed with 52abb700e16a9a
>>
>> How can I find it ?
>> I tried searching in various tree on git.kernel.org,
>> but could not find the fix.
>
> It's in Linus tree.
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=52abb700e16a9aa4cbc03f3d7f80206cbbc80680

Thank you !
In fact I don't know how to use this interface to search by commit number.
Do you know if it is possible ?
