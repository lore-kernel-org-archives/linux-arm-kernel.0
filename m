From: deepa.kernel@gmail.com (Deepa Dinamani)
Date: Sat, 14 Jul 2018 08:54:17 -0700
Subject: [PATCH] [RFC] y2038: globally rename compat_time to old_time32
In-Reply-To: <20180713133204.3123939-1-arnd@arndb.de>
References: <20180713133204.3123939-1-arnd@arndb.de>
Message-ID: <CABeXuvphoYM+KOGPgtsuxzS1_XDSOO0Ta5hr3sA7gYtt-78wtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right now we only have compat syscalls and native syscalls.
Until we transition all the architectures to use the new syscalls,
wouldn't it be the same sort of confusion as exists today?
These structures today are still used by compat entry points.
I'm trying to understand why such a cleanup would make sense today
rather than at the end of the transition.

-Deepa
