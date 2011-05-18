From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 May 2011 15:53:27 +0100
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <201105181047.17309.arnd@arndb.de>
References: <201105181047.17309.arnd@arndb.de>
Message-ID: <BANLkTi=xzrLhHTBynWf4huA9EusfaDwPbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 18 May 2011 09:47, Arnd Bergmann <arnd@arndb.de> wrote:
> This is the draft plan for maintaining the ARM subarchitectures in a common
> tree, as a way to help coordinate the upstream merging of the
> arch/arm/{plat,mach}-* changes into Linus' tree.

For clarification - the aim of this subarchitecture group is not only
to coordinate the upstream merging but also take an active (primary)
role in consolidating the existing code across various
subarchitectures under arch/arm/.

> We are also open to nominations for
> further people outside of Linaro to join us as committers. Marc Zyngier from
> ARM ltd is one of the candidates that has been suggested and I would also
> like to see someone from Google.

This looks fine to me.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8fce5e6..942d052 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -630,6 +630,17 @@ S: Maintained
> ?F: ? ? drivers/amba/
> ?F: ? ? include/linux/amba/bus.h
>
> +ARM SUBARCHITECTURES
> +M: ? ? Arnd Bergmann <arnd@arndb.de>
> +M: ? ? Nicolas Pitre <nico@fluxnic.net>
> +M: ? ? Thomas Gleixner <tglx@linutronix.de>
> +M: ? ? arm at kernel.org

With this additional line on ARM Ltd's behalf:

+M:     Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
(as co-maintainer of the RealView boards and major contributor to the
ARM architecture support code, though the latter isn't covered by this
group)

Thanks,

Catalin
