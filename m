From: mpe@ellerman.id.au (Michael Ellerman)
Date: Fri, 10 Feb 2017 14:41:37 +1100
Subject: [PATCH 1/3] kprobes: introduce weak variant of
 kprobe_exceptions_notify
In-Reply-To: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
References: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
Message-ID: <87vasizp8u.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> kprobe_exceptions_notify() is not used on some of the architectures such
> as arm[64] and powerpc anymore. Introduce a weak variant for such
> architectures.

I'll merge patch 1 & 3 via the powerpc tree for v4.11.

You can then send patch 2 to the arm guys after -rc1, or for 4.12.

cheers
