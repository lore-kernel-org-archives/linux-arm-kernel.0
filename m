From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 17 Nov 2014 14:24:43 +0000
Subject: [PATCH v12 11/15] arm: omap1: Migrate debug_ll macros to use
 8250.S
In-Reply-To: <5469BAD8.3090006@linaro.org>
References: <1414148076-12685-1-git-send-email-daniel.thompson@linaro.org>
 <1414148076-12685-12-git-send-email-daniel.thompson@linaro.org>
 <20141116002956.GA13220@fuloong-minipc.musicnaut.iki.fi>
 <5469BAD8.3090006@linaro.org>
Message-ID: <546A052B.5050100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/14 09:07, Daniel Thompson wrote:
> On 16/11/14 00:29, Aaro Koskinen wrote:
>> Hi,
>>
>> On Fri, Oct 24, 2014 at 11:54:32AM +0100, Daniel Thompson wrote:
>>> +	config DEBUG_OMAP1UART1
>>> +		bool "Kernel low-level debugging via OMAP1 UART1"
>>> +		depends on ARCH_OMAP1
>>> +		select DEBUG_UART_8250
>>> +		help
>>> +		  Say Y here if you want kernel low-level debugging support
>>> +		  on OMAP1 based platforms (expect OMAP730) on the UART1.
>> [...]
>>> +		  on OMAP1 based platforms (expect OMAP730) on the UART2.
>> [...]
>>> +		  on OMAP1 based platforms (expect OMAP730) on the UART3.
>>                                             ^^^^^^
>>
>> Spelling again wrong. I think it was already corrected in v11?
> 
> Sorry and, yes, you're right this was corrected in v11.
> 
> I was travelling when I posted v11 so I guess I must have forgot to pull
> the right branches to my main machine. I will dig it and diff shortly to
> make sure I didn't miss anything else.

Just as well I did the diff. v12 was derived from v9 rather than v11 as
it should have been, so apologies to Aaro and Paul Bolle for dropping
changes they asked for.

I will try to change how I keep track of things when I go travelling in
future...


Daniel.
