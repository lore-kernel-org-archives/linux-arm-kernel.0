From: rkrcmar@redhat.com (Radim =?utf-8?B?S3LEjW3DocWZ?=)
Date: Thu, 18 May 2017 20:34:05 +0200
Subject: [PULL 00/13] KVM/ARM Fixes for v4.12-rc2
In-Reply-To: <20170518094722.9926-1-cdall@linaro.org>
References: <20170518094722.9926-1-cdall@linaro.org>
Message-ID: <20170518183405.GB7438@potion>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-05-18 11:47+0200, Christoffer Dall:
> Hi Radim and Paolo,
> 
> Here is a fairly large set of fixes post -rc1 for KVM/ARM.
> 
> The fixes include:
>  - A fix for a build failure introduced in -rc1 when tracepoints are
>    enabled on 32-bit ARM.
>  - Disabling use of stack pointer protection in the hyp code which can
>    cause panics.
>  - A handful of VGIC fixes.
>  - A fix to the init of the redistributors on GICv3 systems that
>    prevented boot with kvmtool on GICv3 systems introduced in -rc1.
>  - A number of race conditions fixed in our MMU handling code.
>  - A fix for the guest being able to program the debug extensions for
>    the host on the 32-bit side.

Pulled, thanks.
