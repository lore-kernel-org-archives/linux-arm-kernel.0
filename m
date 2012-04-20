From: stigge@antcom.de (Roland Stigge)
Date: Fri, 20 Apr 2012 09:53:47 +0200
Subject: [PATCH v4] i2c: Add device tree support to i2c-pnx.c
In-Reply-To: <20120420072811.GA9769@pengutronix.de>
References: <1334850612-24151-1-git-send-email-stigge@antcom.de>
 <20120419160715.GD24987@pengutronix.de> <4F903E0C.6010604@antcom.de>
 <20120419203915.GB28005@pengutronix.de> <4F90812F.5090106@antcom.de>
 <20120420072811.GA9769@pengutronix.de>
Message-ID: <4F91160B.5070802@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2012 09:28 AM, Wolfram Sang wrote:
>> Another solution would be to not use timeout with the dt enabled 
>> i2c-pnx for now (using the hard coded default timeout as the
>> current i2c-pnx.c does) and possibly introduce the (anyway
>> optional) "timeout" later.
> 
> Yeah, let's do it like this.

Good, will do!

>> Interesting! When the documentation is outdated - how does the
>> parser actually decide between hex (e.g. regs/addresses) and dec
>> (e.g. clock-frequency) in the absence of "0x"?
> 
> Are there regs without 0x?

Lots of, in Documentation/devicetree/booting-without-of.txt ;-)
Admittedly, not in arch/arm/boot/dts/*...

I would like to clarify the hex/dec issue and the various examples to
prevent confusion of others. Will post a patch.

Roland
