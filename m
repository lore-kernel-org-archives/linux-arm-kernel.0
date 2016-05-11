From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 May 2016 11:42:05 +0100
Subject: [patch V4 02/31] bitops: Include generic parity.h in some
 architectures' bitops.h
In-Reply-To: <1462957641-24241-1-git-send-email-zengzhaoxiu@163.com>
References: <1462955158-28394-1-git-send-email-zengzhaoxiu@163.com>
 <1462957641-24241-1-git-send-email-zengzhaoxiu@163.com>
Message-ID: <20160511104205.GE3051@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 05:06:17PM +0800, zengzhaoxiu at 163.com wrote:
> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> 
> Simply use the generic version.
> 
> Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no> [for avr32]
> ---
>  arch/arc/include/asm/bitops.h      | 1 +
>  arch/arm/include/asm/bitops.h      | 1 +
>  arch/arm64/include/asm/bitops.h    | 1 +
>  arch/avr32/include/asm/bitops.h    | 1 +
>  arch/c6x/include/asm/bitops.h      | 1 +
>  arch/cris/include/asm/bitops.h     | 1 +
>  arch/frv/include/asm/bitops.h      | 1 +
>  arch/h8300/include/asm/bitops.h    | 1 +
>  arch/hexagon/include/asm/bitops.h  | 1 +
>  arch/m32r/include/asm/bitops.h     | 1 +
>  arch/m68k/include/asm/bitops.h     | 1 +
>  arch/metag/include/asm/bitops.h    | 1 +
>  arch/mn10300/include/asm/bitops.h  | 1 +
>  arch/openrisc/include/asm/bitops.h | 1 +
>  arch/parisc/include/asm/bitops.h   | 1 +
>  arch/s390/include/asm/bitops.h     | 1 +
>  arch/sh/include/asm/bitops.h       | 1 +
>  arch/xtensa/include/asm/bitops.h   | 1 +

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
