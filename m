From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 10 Feb 2017 08:50:30 +0100
Subject: [PATCH 1/3] kprobes: introduce weak variant of
 kprobe_exceptions_notify
In-Reply-To: <87vasizp8u.fsf@concordia.ellerman.id.au>
References: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
 <87vasizp8u.fsf@concordia.ellerman.id.au>
Message-ID: <20170210075030.GA24405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Michael Ellerman <mpe@ellerman.id.au> wrote:

> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> 
> > kprobe_exceptions_notify() is not used on some of the architectures such
> > as arm[64] and powerpc anymore. Introduce a weak variant for such
> > architectures.
> 
> I'll merge patch 1 & 3 via the powerpc tree for v4.11.

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
