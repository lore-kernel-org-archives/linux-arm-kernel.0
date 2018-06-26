From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 26 Jun 2018 10:23:44 +0200
Subject: [PATCH] arm: dts: pxa3xx: Add ssp ports to pxa3xx device tree
In-Reply-To: <20180624174134.20581-1-daniel@zonque.org> (Daniel Mack's message
 of "Sun, 24 Jun 2018 19:41:34 +0200")
References: <20180624174134.20581-1-daniel@zonque.org>
Message-ID: <87d0welzvz.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> Also fix the documentation for these bindings.
>
> The DMA properties have to be passed in the ssp users for now.
>
> Signed-off-by: Daniel Mack <daniel@zonque.org>
Applied to pxa/dt.

For completeness, you could always add another patch for pxa27x.dtsi to ssp
ports :)

Cheers.

--
Robert
