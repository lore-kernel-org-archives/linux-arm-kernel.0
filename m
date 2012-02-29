From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 Feb 2012 18:29:38 +0000
Subject: [PATCH v2 0/3] ARM support for syscall tracing
In-Reply-To: <4F4E3780.4060904@mentor.com>
References: <4F44FF58.3060907@mentor.com>
 <4F4E3780.4060904@mentor.com>
Message-ID: <20120229182937.GM2983@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wade,

On Wed, Feb 29, 2012 at 02:34:40PM +0000, Wade Farnsworth wrote:
> This is a rework of Steven Walter's syscall tracing patches first
> posted here:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074454.html
> 
> I've rebased the patches against the current mainline master branch, as well
> as implemented several changes based on feedback from Will Deacon and
> Russel King.
> 
> v2: - Tested on EABI and OABI.
>     - Removed an instance of the ?: operator in syscall_set_return_value()
>     - Moved #define of NR_syscalls to syscall.h
>     - Changed the test of NR_syscalls vs __NR_syscalls in entry-common.S
>       to .ifne
> 
> Wade Farnsworth (3):
>   ARM: add support for the generic syscall.h interface
>   ARM: add TRACEHOOK support
>   ARM: support syscall tracing

I'm pretty happy with these three patches now, so feel free to add:

Reviewed-by: Will Deacon <will.deacon@arm.com>

Once Russell is ok with them you can put them in the patch system.

Cheers,

Will
