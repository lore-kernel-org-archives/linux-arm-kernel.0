From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Mar 2013 21:31:07 +0000
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <20130321201807.7cb04978@skate>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <201303211903.52383.arnd@arndb.de> <20130321201807.7cb04978@skate>
Message-ID: <201303212131.07629.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 March 2013, Thomas Petazzoni wrote:
> In the mean time can we do something like:
> 
>         soc {
>                 compatible = "simple-bus";
>                 range = <...>;
> 
>                 [... all the peripherals ...]
>         };
> 
> with the range = <...> property converting the peripheral registers
> base address (expressed as offsets in the reg = <...> properties of the
> subnodes) into the absolute physical address?

Yes, that is what Rob suggested you do.
 
> I'm planning to work on the DT binding for the mvebu-mbus driver as
> soon as the PCIe driver gets accepted, but it would be good to have an
> intermediate solution to get the LPAE support in.

Sounds good.

	Arnd
