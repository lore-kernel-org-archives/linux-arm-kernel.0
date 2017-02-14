From: patch-notifications@ellerman.id.au (Michael Ellerman)
Date: Tue, 14 Feb 2017 23:40:25 +1100 (AEDT)
Subject: [1/3] kprobes: introduce weak variant of kprobe_exceptions_notify
In-Reply-To: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
Message-ID: <3vN27s2kxcz9s7M@ozlabs.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-02-07 at 19:54:14 UTC, "Naveen N. Rao" wrote:
> kprobe_exceptions_notify() is not used on some of the architectures such
> as arm[64] and powerpc anymore. Introduce a weak variant for such
> architectures.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fc62d0207ae0ebc9d19df68394c0dc

cheers
