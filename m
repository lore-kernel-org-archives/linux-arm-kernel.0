From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 11 Jun 2014 09:39:34 +0200
Subject: Question on perf counter
In-Reply-To: <CALU2kfkKzVkPgvhDbk_MuTwhi7Jyo1g6Na7+uwQG=CMq2uFq8g@mail.gmail.com>
References: <CALU2kfkKzVkPgvhDbk_MuTwhi7Jyo1g6Na7+uwQG=CMq2uFq8g@mail.gmail.com>
Message-ID: <CAORVsuWSis8-w_iB_2pgvs=ptkspjdXpENEb_AA3-hgAZivkkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt,

On Wed, Jun 11, 2014 at 3:07 AM, Mathew Li <mathew.li100@gmail.com> wrote:
> Hi All,
>
> I have a piece of kernel code (actually some assembly functions) on
> ARM-v8. I want to know how many cycles CPU is taking to execute them.
> I believe I could use performance counter for this job. So are there
> some APIs in kernel for performance counter for ARM-v8 which I could
> make use of?

The kernel has the profiling tools for that.
Perf has a lot of features that you need to experiment with. Cf.
https://wiki.linaro.org/LEG/Engineering/TOOLS/tracing-and-profiling-tools
and https://wiki.yoctoproject.org/wiki/Tracing_and_Profiling for
detailed information and usage of perf, ftrace ...

Regards,
Jean

>
> Thanks!
> Matt
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
