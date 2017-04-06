From: agraf@suse.de (Alexander Graf)
Date: Thu, 6 Apr 2017 10:28:11 +0200
Subject: [PATCH v3 0/5] Support userspace irqchip with arch timers
In-Reply-To: <20170405092815.22503-1-cdall@linaro.org>
References: <20170405092815.22503-1-cdall@linaro.org>
Message-ID: <6e406e74-5047-1bc1-d25f-3984d3da81f1@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05.04.17 11:28, Christoffer Dall wrote:
> This series is the second version of the rework of the patches to support
> architected timers with a userspace irqchip sent by Alexander Graf [1].
>
> We first cleanup some of the timer code to make it easier to understand
> what is being done in the later patches, and then define the ABI,
> implement timers support, implement PMU support, and finally advertise
> the features.
>
> These patches are based on the recent work from Jintack to support the
> physical timer in addition to the virtual timer.  This series including
> its dependencies can be found here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/cdall/linux.git irqs-to-user-v3
>
> I tested this using Alex's QEMU patch with his fixes for SMP applied.  This
> seems to be rock-solid.  The temporary-not-for-upstream-but-for-testing patch
> can be found here (force-pushed and rebased since v2):
>
> https://git.linaro.org/people/christoffer.dall/qemu-arm.git no-kvm-irqchip
>
> I also tested it on 32-bit and it looks good there as well.

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex
