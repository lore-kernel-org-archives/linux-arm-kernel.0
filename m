From: marex@denx.de (Marek Vasut)
Date: Wed, 29 Aug 2018 12:33:35 +0200
Subject: [RFC] Rename socfpga_cyclone5_de0_sockit.dts to
 socfpga_cyclone5_de0_nano_soc.dts
In-Reply-To: <73bm9lwn3t.fsf@pengutronix.de>
References: <fd0f01e5-41a2-6a24-2ce4-482b30b348b6@denx.de>
 <73bm9lwn3t.fsf@pengutronix.de>
Message-ID: <b29e529a-f7bd-71d2-615e-9f850858ed4d@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/2018 11:14 AM, Steffen Trumtrar wrote:
> 
> Marek Vasut <marex@denx.de> writes:
> 
>> Hi,
>>
>> I was recently experimenting with the DE0 Nano SoC / Atlas SoC . I had a
>> hard time finding the right DT for the board, but then was suggested
>> that the DT for the board is socfpga_cyclone5_de0_sockit.dts . This did
>> not make sense to me, since SoCKit is a different board altogether. But
>> the DTS seems to be indeed for the DE0 Nano SoC.
>>
>> To fix up this confusion, I'd propose renaming of the
>> socfpga_cyclone5_de0_sockit.dts to socfpga_cyclone5_de0_nano_soc.dts to
>> match the label on the package .
>>
>> What do you think ?
> 
> Ack. This confusion came up multiple times. The barebox-specific dts
> "overlay"
> is already named socfpga_cyclone5_de0_nano_soc.dts because of this.

The DT in U-Boot is also called socfpga_cyclone5_de0_nano_soc.dts since
forever. I'd be happy to send a patch if the Altera folks are fine with it?

-- 
Best regards,
Marek Vasut
