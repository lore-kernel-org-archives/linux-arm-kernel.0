From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Jul 2014 10:57:18 +0100
Subject: [PATCH 0/6] LLVMLinux: Patches to enable the kernel to be
 compiled with clang/LLVM
In-Reply-To: <1404850576-2006-1-git-send-email-behanw@converseincode.com>
References: <1404850576-2006-1-git-send-email-behanw@converseincode.com>
Message-ID: <20140709095718.GD9485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 09:16:10PM +0100, behanw at converseincode.com wrote:
> From: Behan Webster <behanw@converseincode.com>
> 
> The LLVMLinux project aims to fully build the Linux kernel using both gcc and
> clang (the C front end for the LLVM compiler infrastructure project). 
> 
> Clang only supports global named registers for non-allocatable registers like
> the stack pointer. By centralizing the definition of current_stack_pointer, the
> use of named registers for ARM remains largely unchanged while working for both
> gcc and clang.

All looks sane to me. For the series:

  Acked-by: Will Deacon <will.deacon@arm.com>

BTW, have you tried building an arm64 kernel with clang?

Will
