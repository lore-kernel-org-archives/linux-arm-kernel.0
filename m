From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Dec 2012 17:59:01 +0000
Subject: [PATCH v3 0/6] Add support for a fake, para-virtualised machine
In-Reply-To: <1355853196-23676-1-git-send-email-will.deacon@arm.com>
References: <1355853196-23676-1-git-send-email-will.deacon@arm.com>
Message-ID: <201212181759.01676.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 December 2012, Will Deacon wrote:
> This is version three of the patches originally posted here:
> 
>   v1.) http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/135870.html
>   v2.) http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/137750.html
> 
> Thanks to all those who have provided comments so far.
> Changes for v3 include:
> 
>         * Ripped out *even more* SMP code by rebasing onto latest
>           mainline
>         * Removed function-base property from device-tree binding
>         * Annotated the low-level firmware invocation functions with
>           noinline to clarify intent
>         * Minor cleanups
> 
> As usual, testing this relies on KVM support for PSCI, a magic kvmtool
> and Mark Rutland's arch-timer patches.
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
