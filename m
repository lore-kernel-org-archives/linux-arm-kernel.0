From: jonathan.austin@arm.com (Jonathan Austin)
Date: Fri, 03 Aug 2012 16:37:58 +0100
Subject: [PATCH v6 0/3] Updated Cortex-M3 series
In-Reply-To: <20120803145035.GJ2626@pengutronix.de>
References: <1343988614-5508-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201208031407.09092.arnd@arndb.de> <20120803145035.GJ2626@pengutronix.de>
Message-ID: <501BF056.5000801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/12 15:50, Uwe Kleine-K?nig wrote:

...
>  
>> How does this relate to the ARMv6-M (Cortex-M0/M0+/M1) support
>> that has been floating around [1]? Can we support both in
>> the same kernel? 
> I don't know M0/M1 but from a quick look at the tree you pointed out I'd
> say they look reasonably similar.
> 

I'm not so sure - M0/M0+/M1 don't use Thumb-2, they're a slightly
extended version of Thumb-1, which we don't support in the kernel...

For the curious, here are the relevant bits from the ARM ARMs

>From the ARM (v6-M) ARM A4.1 - about the instruction set:

"ARMv6-M supports the Thumb instruction set including a small number of
32-bit instructions introduced with Thumb-2 technology, see 32-bit Thumb
instruction encoding on page A5-91. The 16-bit instruction
support is equivalent to the Thumb instruction set support in ARMv6
prior to the introduction of Thumb-2 technology."

Whereas for V7-M, it says:
"supports a large number of 32-bit instructions that Thumb-2 technology
introduced into the Thumb instruction set. Much of the functionality
available is identical to the ARM instruction set supported alongside
the Thumb instruction set in ARMv6T2 and other ARMv7 profiles"

Jonny
