From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 15 May 2015 10:37:31 +0530
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <20150515041632.GG6348@linux>
References: <555218C7.5050602@free.fr>
 <20150512155004.GP2067@n2100.arm.linux.org.uk>
 <555380F8.5050306@free.fr>
 <CAOh2x==aCLxCWX9K57hOFVEP1eLo_OYZPe0YvbFvpkXcoSp_hQ@mail.gmail.com>
 <5554858A.9010207@free.fr> <20150514115456.GB23999@linux>
 <55549DEE.6010202@free.fr>
 <CAKohpon4AV-7nq=Qm7PpDbbW9ti98avY9zz82htzyHWi5_K7fA@mail.gmail.com>
 <5554B5C1.2070402@free.fr> <20150515041632.GG6348@linux>
Message-ID: <20150515050731.GH6348@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-05-15, 09:46, Viresh Kumar wrote:
> The logic is this:
> - Oneshot mode is only useful if we are going to support NO_HZ mode.
>   i.e. we can disable the clkevt device during CPU idle ..

Minor correction. The last line talks about NO_HZ_IDLE instead. NO_HZ
is about disabling to tick when not required.

-- 
viresh
