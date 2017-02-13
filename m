From: naveen.n.rao@linux.vnet.ibm.com (Naveen N. Rao)
Date: Mon, 13 Feb 2017 14:02:50 +0530
Subject: [PATCH 1/3] kprobes: introduce weak variant of
 kprobe_exceptions_notify
In-Reply-To: <87vasizp8u.fsf@concordia.ellerman.id.au>
References: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
 <87vasizp8u.fsf@concordia.ellerman.id.au>
Message-ID: <20170213083250.GE7674@naverao1-tp.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/02/10 02:41PM, Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> 
> > kprobe_exceptions_notify() is not used on some of the architectures such
> > as arm[64] and powerpc anymore. Introduce a weak variant for such
> > architectures.
> 
> I'll merge patch 1 & 3 via the powerpc tree for v4.11.
> 
> You can then send patch 2 to the arm guys after -rc1, or for 4.12.

Sure, thanks!

- Naveen
