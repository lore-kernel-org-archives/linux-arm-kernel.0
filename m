From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 May 2015 10:00:13 +0100
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
Message-ID: <20150515090013.GE2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 09:46:32AM +0530, Viresh Kumar wrote:
> What core does your platform has? Cortex A9? Doesn't that uses this
> timer instead: drivers/clocksource/arm_arch_timer.c ?

Cortex A9 doesn't always have the architected timer.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
