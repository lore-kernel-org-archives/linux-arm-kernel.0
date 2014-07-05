From: jhbird.choi@samsung.com (Jonghwan Choi)
Date: Sat, 05 Jul 2014 09:40:38 +0900
Subject: [PATCH] thermal: Add missing cpumask_clear
In-Reply-To: <53B747FF.5010604@gmail.com>
References: <000001cf9771$e2f465c0$a8dd3140$@samsung.com>
 <CAK5sBcHDTgyj67xVWgtNH-Z7XU1Ykp6m650_mWBVp=Az2P6f=Q@mail.gmail.com>
 <000101cf97e0$f9ba7a50$ed2f6ef0$@samsung.com> <53B747FF.5010604@gmail.com>
Message-ID: <000801cf97e9$bde80f70$39b82e50$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 5, 2014 at 9:34 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> > Console message-> 4.861157] [c6] --ID [ 1] = 0,4-5,7 (4,5,7 cpu bit
> > was set.)
> >
> > And when I tried to register two cooling devices with cpumask_set_cpu(0, &mask_val) and
> cpumask_set_cpu(4, &mask_val).
> >
> > I found that cpu 0 bit is also set in latter cpumask. (I hope latter
> > cpumask has a cpu 4 bit.)
> >
> > So I think that cpumask_clear should be inserted.
> 
> I believe Sachin's concern was related to your patch description. A good description should say what
> the patch changes and what is the rationale behind this change. Also for fixes it is a good practice
> to specify observed issues in patch description as well.
> 
> Best regards,

-> You are right.

Thanks for your kind advice.


Best regards.
