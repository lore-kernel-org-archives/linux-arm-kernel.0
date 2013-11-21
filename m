From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 Nov 2013 20:03:44 +0000
Subject: ACPI
In-Reply-To: <201311191915.57516.arnd@arndb.de>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <201311191915.57516.arnd@arndb.de>
Message-ID: <20131121200344.GD14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 07:15:57PM +0100, Arnd Bergmann wrote:

> of them apply here. You keep saying "servers", but that isn't actually
> a feature of how the system is designed, rather than what is running
> on them. Given these examples (or any others, you could come up with),
> which ones do you actually see as relevant here:

> 1. An exterprise server (SPARC enterprise M9000, Power 795, Integrity
>    Superdome) with the CPU core changed to run ARM instructions
> 2. An ATX whitebox server mainboard with one to four sockets and PC
>    peripherals and plug-compatible ARM CPU chips.
> 3. A purpose-built server SoC based on standard components
> 4. A new server SoC based on an older proprietary embedded or mobile
>    SoC design (think Exynos, OMAP, Snapdragon, ... based)
> 5. A server built from using a cheap devboard (BeagleBone, Cubieboard, ...
>    style) with an unmodified SoC.
> 6. A virtual machine running on KVM or Xen.

I'd also ask if we need to consider desktops and laptops here - do we
really mean distros here rather than servers, even if servers are the
primary use case for distros right now?

> The other really helpful would be a list of things that actually
> speak in favor of doing ACPI, from a system design perspective.
> What is it that people want out of it?

+1.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131121/c28c9a46/attachment.sig>
