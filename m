From: ricard.wanderlof@axis.com (Ricard Wanderlof)
Date: Thu, 12 Sep 2013 15:25:45 +0200
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130912115549.GI12758@n2100.arm.linux.org.uk>
References: <20130910180704.GB29403@sirena.org.uk>
 <522FD78A.6080900@freescale.com> <20130911104126.GN29403@sirena.org.uk>
 <52304BFF.4060007@freescale.com> <20130911113002.GP29403@sirena.org.uk>
 <523186DF.4070203@freescale.com>
 <1378982395.2627.416.camel@shinybook.infradead.org>
 <20980858CB6D3A4BAE95CA194937D5E73EA0EE8B@DBDE04.ent.ti.com>
 <1378984665.2627.423.camel@shinybook.infradead.org>
 <20130912114831.GL29403@sirena.org.uk>
 <20130912115549.GI12758@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1309121523130.2394@lnxricardw.se.axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 12 Sep 2013, Russell King - ARM Linux wrote:

> On Thu, Sep 12, 2013 at 12:48:31PM +0100, Mark Brown wrote:
>> On Thu, Sep 12, 2013 at 12:17:45PM +0100, David Woodhouse wrote:
>>
>>> Right. The issue here is that the LUT is currently *pre-populated*, with
>>> an incestuously-"known" set of commands that the slave is expected to
>>> support.
>>
>> So, to repeat my earlier question can someone tell me what a LUT is?
>
> It's a very common abbreviation - Look Up Table.
>
> More specifically, it's a set of registers which give the SPI controller
> a sequence of 16-bit commands to execute, which tell it what to do on
> the SPI bus.  Each register contains two commands, and it executes them
> ...

A bit of an odd name when used in this context I think; LUTs are usually 
used to perform mapping or transformation functions, e.g. looking up a 
value 'y' given an input value 'x'. In this case it's just a table of 
commands to be executed. But I guess the name LUT has been used in some 
hardware specification so there's not much we can do about it.

/Ricard
-- 
Ricard Wolf Wanderl?f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
