From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Jan 2013 18:24:01 -0800
Subject: [PATCH] MAINTAINERS: Add ARM/Zynq architecture entry
In-Reply-To: <1358786701-28414-1-git-send-email-michal.simek@xilinx.com>
References: <1358786701-28414-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <CAOesGMg8LtNxjxvmjUXjwv=SCuEtNdR_tE64D54P1TS6Csyo3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 8:45 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Applied (by cherry-pick from a branch pull request, but following up
here none the less. :)


-Olof
> ---
>  MAINTAINERS |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4e2a1f6..61bf074 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1264,6 +1264,14 @@ S:       Maintained
>  F:     arch/arm/mach-pxa/z2.c
>  F:     arch/arm/mach-pxa/include/mach/z2.h
>
> +ARM/ZYNQ ARCHITECTURE
> +M:     Michal Simek <michal.simek@xilinx.com>
> +L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +W:     http://wiki.xilinx.com
> +T:     git git://git.xilinx.com/linux-xlnx.git
> +S:     Supported
> +F:     arch/arm/mach-zynq/
> +
>  ARM64 PORT (AARCH64 ARCHITECTURE)
>  M:     Catalin Marinas <catalin.marinas@arm.com>
>  M:     Will Deacon <will.deacon@arm.com>
> --
> 1.7.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
