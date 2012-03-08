From: jp.francois@cynove.com (jean-philippe francois)
Date: Thu, 8 Mar 2012 16:26:56 +0100
Subject: Regression in 3.2.9 for omap-serial (at least)
In-Reply-To: <alpine.LFD.2.02.1203081246130.2742@ionos>
References: <lyk42vxsz2.fsf@ensc-virt.intern.sigma-chemnitz.de>
 <alpine.LFD.2.02.1203081246130.2742@ionos>
Message-ID: <CAGGh5h3-1XhMO1-jiBdUJYgh4unRcPonvp=zcXLKMJBfS+qpuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 8 mars 2012 12:46, Thomas Gleixner <tglx@linutronix.de> a ?crit :
> On Thu, 8 Mar 2012, Enrico Scholz wrote:
>> Hi,
>>
>> the commit "genirq: Unmask oneshot irqs when thread was not woken"[1]
>> breaks at least the omap-serial driver which requests a shared interrupt
>
> Fixed with 52abb700e16a9a

How can I find it ?
I tried searching in various tree on git.kernel.org,
but could not find the fix.
>
> Thanks,
>
> ? ? ? ?tglx
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
