From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 3 May 2013 14:17:54 +0100
Subject: [PATCH v3 00/32] Port of KVM to arm64
In-Reply-To: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130503131754.GC21621@localhost.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 05:17:02PM +0100, Marc Zyngier wrote:
> This series contains the third version of KVM for arm64.
> 
> It depends on the following branches/series:
> - git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git soc-armv8-model
>   Catalin's platform support branch for v8 models

After 3.10-rc1 you should be able to base it on the mainline kernel (or
-rc2 if something breaks).

> The code is unsurprisingly extremely similar to the KVM/arm code, and
> a lot of it is actually shared with the 32bit version. Some of the
> include files are duplicated though (I'm definitely willing to fix
> that).

As it was already commented, some of the commonality could be shared via
virt/kvm/ (timers, gic).

Apart from the other comments I (and the others) had, the series looks
fine and in shape for 3.11. Looking forward to see v4...

Thanks.

-- 
Catalin
