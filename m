From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon, 08 Oct 2018 11:10:59 +0200
Subject: [PATCH] ARM: dts: socfpga: arria10: add aliases for ethernet
In-Reply-To: <e38342bf-0add-ef97-2f38-ca5471f35f19@kernel.org>
References: <20180928121643.18100-1-s.trumtrar@pengutronix.de>
 <6dd30835-b56c-8322-2c1e-e8c09c7bcc4c@kernel.org>
 <e38342bf-0add-ef97-2f38-ca5471f35f19@kernel.org>
Message-ID: <73zhvon6qk.fsf@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dinh Nguyen <dinguyen@kernel.org> writes:

> On 09/28/2018 10:47 AM, Dinh Nguyen wrote:
>> 
>> 
>> On 09/28/2018 07:16 AM, Steffen Trumtrar wrote:
>>> The stmmac driver uses the alias id to enumerate multiple 
>>> ethernet devices.
>>> Add the aliases for ethernet, so multiple ethernet ports can 
>>> be enabled
>>> without errors.
>>>
>>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>> ---
>>>  arch/arm/boot/dts/socfpga_arria10.dtsi | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>> 
>> Applied, thanks!
>
> I don't think we can add these ethernet aliases to the base 
> arria10 dtsi
> file. The reason is that different boards may elect to use other 
> gmacs
> instead of gmac0.
>
> Do you agree?
>

Ack. I was following socfpga.dtsi, but I'm going to fix it instead 
of following it ;-)

Steffen

-- 
Pengutronix e.K.                          | Steffen Trumtrar 
|
Industrial Linux Solutions                | 
http://www.pengutronix.de/ |
Peiner Str. 6-8, 31137 Hildesheim, Germany| Phone: 
+49-5121-206917-0   |
Amtsgericht Hildesheim, HRA 2686          | Fax: 
+49-5121-206917-5555|
