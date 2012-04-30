From: davej@redhat.com (Dave Jones)
Date: Mon, 30 Apr 2012 10:06:45 -0400
Subject: CPUFREQ maintainence.
Message-ID: <20120430140645.GB12583@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This last few releases I've been more of a hindrance than help to getting
some of the patches merged upstream, so due to my lack of time, I'm considering
removing myself as maintainer, and having patches routed as such instead...

ARM -> Russell/relevant ARM subtree maintainers
x86 driver patches -> x86 at vger.kernel.org
(All the other archs currently supported already go through the arch trees mips/sparc etc)

The core doesn't see a huge amount of change these days, I figure patches for
that can just go to lkml & Linus/Andrew like any other subsystem.

comments?

	Dave
