From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Dec 2013 03:53:51 +0100
Subject: Moschip MCS8142 SoC
In-Reply-To: <CAGVrzcYWzb95j2qVKWqZ1iVrR9Ak8bX6ej8hZS_6TQ_eEBp+pg@mail.gmail.com>
References: <OF433D4F00.CB35F8E7-ON86257C37.004F3E8D@rockwellcollins.com>
 <201312060331.31958.arnd@arndb.de>
 <CAGVrzcYWzb95j2qVKWqZ1iVrR9Ak8bX6ej8hZS_6TQ_eEBp+pg@mail.gmail.com>
Message-ID: <201312060353.51538.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 December 2013, Florian Fainelli wrote:
> I still plan on submitting support for the MCS8140 soon (just need some
> home internet connection),

Ah, cool!

> although due to the major CPU difference we will
> probably have a hard time building the same kernel image for all MCS SoCs.
> At least we should target MULTI_V4 and MULTI_V5.

I was wondering about this: Jonas had some problems with kernels that enable
both ARM9 and FA526 support, IIRC. We didn't get to the bottom of this, but
for all I can tell, the infrastructure should already be there to support
a multiplatform kernel with any combination of ARMv4/v4t/v5 cores enabled.

	Arnd
