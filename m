From: broonie@kernel.org (Mark Brown)
Date: Mon, 1 Sep 2014 19:11:52 +0100
Subject: [RFC PATCH for Juno 1/2] net: smsc911x add support for probing
 from ACPI
In-Reply-To: <20140901173245.GM2953@xora-haswell.xora.org.uk>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
 <1409583961-7466-2-git-send-email-hanjun.guo@linaro.org>
 <20140901170447.GF608@arm.com> <21764799.KDNDm9XRax@wuerfel>
 <20140901173245.GM2953@xora-haswell.xora.org.uk>
Message-ID: <20140901181152.GL29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 06:32:45PM +0100, Graeme Gregory wrote:

> This will of course most likely be replaced by _DSD values. I just
> hardcoded for now as _DSD is not yet in the kernel and issues around
> maintenance of bindings are not solved (unless this happened at KS where
> I was not present).

Not really.  AIUI the official thing is still some combination of
getting a DT binding defined and then use that verbatim (as the x86
embedded people want to though I'm still not clear that the Windows
people are on board with this) and the UEFI processes.  It's possible I
misunderstood though.

Realistically if something is usable on x86 embedded it's going to be
supported on ARMv8 servers too unless we jump through hoops, and even
there real implementations in the wild will probably win out.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140901/ff5aaa8e/attachment.sig>
