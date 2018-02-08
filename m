From: rasmus.villemoes@prevas.dk (Rasmus Villemoes)
Date: Thu, 8 Feb 2018 15:24:40 +0100
Subject: [PATCH] ARM: dts: ls1021a: add quadspi node
In-Reply-To: <20180205080323.GP31354@dragon>
References: <20180126142014.13819-1-rasmus.villemoes@prevas.dk>
 <20180205080323.GP31354@dragon>
Message-ID: <43c533e2-2b93-9672-3905-5f4ba8d6db19@prevas.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-02-05 09:03, Shawn Guo wrote:
> On Fri, Jan 26, 2018 at 03:20:14PM +0100, Rasmus Villemoes wrote:
>> Add a node to device tree repesenting the QuadSPI controller present on
>> LS1021a. Driver support has been present since e8c034b2fbe5 (mtd:
>> spi-nor: fsl-quadspi: add support for ls1021a).
>>
>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> 
> Applied, thanks.
> 

Sorry, I didn't know you already had a similar patch queued for 4.16
(85f8ee78ab ARM: dts: ls1021a: Add support for QSPI with ls1021a SoC),
so I have to ask you to unapply (or do you want me to send a revert?) -
the ls1021a.dtsi in your imx/dt branch now has two almost-identical
qspi: nodes.

Rasmus
