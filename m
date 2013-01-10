From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Thu, 10 Jan 2013 12:51:15 -0500
Subject: [kvmarm] [PATCH v2 0/2] KVM/ARM implementation of PSCI
In-Reply-To: <1357834005-23843-1-git-send-email-marc.zyngier@arm.com>
References: <1357834005-23843-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CANM98qLCC2D-ZzyS_qbDw417gwz9HDGcQzkOYuXTb7wc-aiaVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 11:06 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> This is an implementation of the Power State Coordination Interface,
> as described there (registration required):
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0022a/index.html
>
> It allows CPUs to be powered on, off, suspended or migrated. This
> series is only concerned with power-{on,off}. KVM Tool uses it to boot
> SMP VMs. This is also supported by the mach-virt platform:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git virt/mach
>
> Tested on the arm64 model, based on kvm-arm-master as of today.
>
> >From v1:
> - Documentation
> - Move the one-time init to a separate function
> - "One mask fits all"
> - Use wait_event_interruptible instead of the open coded version


Thanks, applied.

-Christoffer
