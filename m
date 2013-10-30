From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 30 Oct 2013 14:01:33 +0900
Subject: arm64: add ftrace support
In-Reply-To: <ED7794875F7BEB4F95284BF9597F2D902D1CC5A8@lhreml512-mbx>
References: <ED7794875F7BEB4F95284BF9597F2D902D1CC5A8@lhreml512-mbx>
Message-ID: <527092AD.6000406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2013 08:39 PM, Jens Meier wrote:
> Hi,
>
> I had some problems applying/compiling Akashi?s ftrace patches.
> - There is an invocation of insn.o missing in the first Makefile patch
> - <asm/insn.h> is missing in the patch set as well as in the latest upstream kernel although included from ftrace.c

Yeah, my patches requires "hotpatch code" interfaces from Jiang Liu, Huawei:
    [PATCH v5 0/7] Optimize jump label implementation for ARM64

Sorry for not mentioning it clearly.
Actually <asm/insn.h> is necessary only in patch [2/6].

-Takahiro AKASHI

>
> Best Regards
> Jens
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
