From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 24 May 2018 09:28:19 +0200
Subject: [PATCH v2] ARM: pxa: dts: add pin definitions for extended GPIOs
In-Reply-To: <20180522202232.7981-1-daniel@zonque.org> (Daniel Mack's message
 of "Tue, 22 May 2018 22:22:32 +0200")
References: <20180522202232.7981-1-daniel@zonque.org>
Message-ID: <87a7spy0ks.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> The PXA3xx series features some extended GPIO banks which are named GPIO0_2,
> GPIO1_2 etc. The PXA300, PXA310 and PXA320 have different numbers of such
> pins, and they also have variant-specific register offsets.
>
> Signed-off-by: Daniel Mack <daniel@zonque.org>
Applied to pxa/dt, thanks.

Cheers.

--
Robert
