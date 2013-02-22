From: rusty@rustcorp.com.au (Rusty Russell)
Date: Fri, 22 Feb 2013 11:01:46 +1030
Subject: [PATCH v6 00/46] CPU hotplug: stop_machine()-free CPU hotplug
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
Message-ID: <87mwuxfatp.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> writes:
> Hi,
>
> This patchset removes CPU hotplug's dependence on stop_machine() from the CPU
> offline path and provides an alternative (set of APIs) to preempt_disable() to
> prevent CPUs from going offline, which can be invoked from atomic context.
> The motivation behind the removal of stop_machine() is to avoid its ill-effects
> and thus improve the design of CPU hotplug. (More description regarding this
> is available in the patches).

If you're doing a v7, please put your benchmark results somewhere!

The obvious place is in the 44/46.

Thanks,
Rusty.
