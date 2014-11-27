From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 27 Nov 2014 11:23:45 +0100
Subject: [PATCH] arm: ftrace: Adds support for ftrace operations
In-Reply-To: <20141125182038.04497ec0@gandalf.local.home>
References: <1415372352-15664-1-git-send-email-jjhiblot@traphandler.com>
 <20141107115225.72bc6cbf@gandalf.local.home>
 <545CFAF4.8030104@traphandler.com>
 <CACh+v5MDFZj+NOPWdnMgNthn_DxL3nn=CZJ224vMh7hSf84o4Q@mail.gmail.com>
 <20141125182038.04497ec0@gandalf.local.home>
Message-ID: <CACh+v5Phr-yA8c_bnooR8eLyEpmiMDwCGi2Oy8ArQayuRbeczA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-26 0:20 GMT+01:00 Steven Rostedt <rostedt@goodmis.org>:
> On Mon, 24 Nov 2014 10:59:24 +0100
> Jean-Jacques Hiblot <jjhiblot@traphandler.com> wrote:
>
>> Hi Steve,
>> did you get a chance of running your tests suite on real hardware with
>> this patch? I'd be really interested in the results.
>
> Yes I finally got it working on my beaglebone white. It passed all the
> tests that passed without it. Although I'm not sure this patch itself
> was tested as I didn't have kprobes which might use it.
>
Thanks for testing it. At least it doesn't cause regression.
What do you mean by not having krpobes which might use it ? Are you
thinking of the kprobe optimization based on ftrace ?

JJ

> -- Steve
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
