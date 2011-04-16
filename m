From: dv@vollmann.ch (Detlef Vollmann)
Date: Sat, 16 Apr 2011 13:27:51 +0200
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <4DA88AFB.7020806@vollmann.ch>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<4DA85B49.60209@vollmann.ch> <4DA86CA8.7090104@atmel.com>
	<4DA88AFB.7020806@vollmann.ch>
Message-ID: <4DA97D37.30607@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/11 20:14, Detlef Vollmann wrote:
> On 04/15/11 18:04, Nicolas Ferre wrote:

>> In fact on at91sam9g20 (and some other at91) you can use the mirroring
>> of the SRAM until next bank... so you end up with a single pool.
>>
>> Base @ sram1 base - sram0 size
>> size = sram 0 size + sram 1 size
> Can you provide details?
> I couldn't find anything in the documentation about this.
Ok, I checked this.  It seems to be an undocumented feature and
its always mirrored.

   Detlef
