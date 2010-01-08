From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 09 Jan 2010 06:33:12 +1100
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909020896AE@mi8nycmail19.Mi8.com>
References: <1262907852.736281.78480196040.1.gpush@pororo>
	<BD79186B4FD85F4B8E60E381CAEE190902089611@mi8nycmail19.Mi8.com>
	<201001081220.14485.jeremy.kerr@canonical.com>
	<201001081426.09754.jk@ozlabs.org>
	<BD79186B4FD85F4B8E60E381CAEE1909020896AE@mi8nycmail19.Mi8.com>
Message-ID: <1262979192.585.42.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-01-08 at 11:25 -0500, H Hartley Sweeten wrote:
> 
> I was just trying to figure out if it was worth trying to use this in
> mach-ep93xx.  It looks like it would be pretty straight forward but
> the implementation is going to use quite a bit more memory because to the
> size of the common struct.
> 
> For now I think I will leave ep93xx as it is. 

How much memory do you have on that platform ? How much more memory is
going to be used by the implementation ?

It may not be the case in this particular instance but I find it funny
when people complain about something that will use a few hundred more
bytes, maybe one or two k more, on machines that have hundreds of MB of
RAM at the expense of code flexibility, reusability and
maintainability :-)
 
Cheers,
Ben.
