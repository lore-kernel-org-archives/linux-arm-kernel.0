From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 19 Dec 2011 12:03:32 -0500 (EST)
Subject: [PATCH v4] ARM: Add generic instruction opcode manipulation
 helpers
In-Reply-To: <1324305365-22514-1-git-send-email-dave.martin@linaro.org>
References: <1324305365-22514-1-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.02.1112191201360.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Dec 2011, Dave Martin wrote:

> This patch adds some endianness-agnostic helpers to convert machine
> instructions between canonical integer form and in-memory
> representation.
> 
> A canonical integer form for representing instructions is also
> formalised here.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> ---
> Changes since v1:
> 
> v4: Rebase on top of Leif's patch which created <asm/opcodes.h>
>     ARM: 7206/1: Add generic ARM instruction set condition code checks.

In that case you might be able to put your patch in the patch system, 
and then go back to add a note for Russell mentioning 7206/1 is a 
prerequisite.


Nicolas
