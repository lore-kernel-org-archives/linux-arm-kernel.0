From: broonie@kernel.org (Mark Brown)
Date: Tue, 2 Sep 2014 17:26:06 +0100
Subject: [Linaro-acpi] [RFC PATCH for Juno 1/2] net: smsc911x add support
 for probing from ACPI
In-Reply-To: <4816592.tj3on6vUaC@wuerfel>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
 <20140901173245.GM2953@xora-haswell.xora.org.uk>
 <20140902132651.GF27056@arm.com> <4816592.tj3on6vUaC@wuerfel>
Message-ID: <20140902162606.GX29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 03:42:53PM +0200, Arnd Bergmann wrote:

> The way I recall the discussion, most people were on one extreme
> side of the discussion or the other:

> a) We should use _DSD for ARM64 servers to maximize code reuse with
> DT-enabled drivers, work around the slow UEFI standardization process,
> remain in control of the actual bindings, and avoid the need for
> endless per-ID platform-data definitions in drivers.

> b) We should never use _DSD at all, since doing that would have no
> advantage over using DT directly, and we should force every device
> manufacturer to specify their bindings in an official ACPI document
> to prevent random incompatible bindings from being established.
> Any device that shows up in servers should not need arbitrary detailed
> properties anyway, as the details are supposed to be hidden in AML.

> I can understand the reasons for both approaches, and I find it hard
> to say either one is invalid. However, the worst possible outcome in
> my opinion would be having to support a mix of the two.

Right, and the x86 embedded folks are going full steam ahead with _DSD
regardless so it seems there will be some systems out there using it
even if they're not ARM servers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140902/7a072e51/attachment.sig>
