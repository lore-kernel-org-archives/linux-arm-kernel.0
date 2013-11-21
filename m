From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 Nov 2013 18:53:18 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <20131121162944.F087FC406A3@trevor.secretlab.ca>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <20131115175241.GB27174@quad.lixom.net>
 <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
 <20131121162944.F087FC406A3@trevor.secretlab.ca>
Message-ID: <20131121185318.GG8120@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 04:29:44PM +0000, Grant Likely wrote:

> We are pushing a lot of boundaries and doing things on ACPI that have
> never been done before. SPI, GPIOs, Clocks, Regulators, composite
> devices, key-value properties. All brand new territory, and the Linux
> world is driving a lot of it.

Indeed, and at a subsystem and platform independent driver level we do
have the x86 embedded platforms working with ACPI right now so Linux is
going to need to cope with some of this regardless of what people end up
doing for ARM servers - Intel are sending me patches for ACPI support in
ASoC for example.

> Personally, I think the issue of ACPI support should be taken on a
> patch-by-patch basis. A lot of the things that need to be done are quite
> discrete and fairly well contained. If the patches don't look that way
> then push back on them. For the parts that look ready, go ahead and
> merge it. Push back on the ones that don't.

+1.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131121/1285621f/attachment.sig>
