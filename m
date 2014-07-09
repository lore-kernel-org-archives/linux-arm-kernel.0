From: andi@firstfloor.org (Andi Kleen)
Date: Wed, 09 Jul 2014 12:33:16 -0700
Subject: [RFC/PATCH RESEND -next 05/21] x86: cpu: don't sanitize early
 stages of a secondary CPU boot
In-Reply-To: <1404905415-9046-6-git-send-email-a.ryabinin@samsung.com> (Andrey
 Ryabinin's message of "Wed, 09 Jul 2014 15:29:59 +0400")
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-6-git-send-email-a.ryabinin@samsung.com>
Message-ID: <87egxunx8j.fsf@tassilo.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrey Ryabinin <a.ryabinin@samsung.com> writes:

> Instrumentation of this files may result in unbootable machine.

This doesn't make sense. Is the code not NMI safe? 
If yes that would need to be fixed because

Please debug more.

perf is a common source of bugs (see Vice Weaver's fuzzer results),
so it would be good to have this functionality for it.

-Andi

-- 
ak at linux.intel.com -- Speaking for myself only
