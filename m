From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 05 Jul 2010 16:14:45 +0100
Subject: Some benchmarks on ARM
References: <20100702180257.GA8767@pengutronix.de>
	<4C2E4D59.8030300@gmail.com> <4C31CEE3.2050202@pengutronix.de>
	<20100705140050.GC19338@n2100.arm.linux.org.uk>
Message-ID: <yw1xocemarkq.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Mon, Jul 05, 2010 at 02:24:03PM +0200, Marc Kleine-Budde wrote:
>> We used a compiler generating hardware floating point instruction by
>> default:
>> 
>> gcc was configured with:
>> "--with-float=softfp --with-fpu=vfp --with-cpu=arm1136jf-s"
>
> This is unclear that it's generating hardware floating point instructions.
> The --with-float=softfp suggests its using soft-fp.

That configuration will generate hardware vfp instructions while using
softfloat calling conventions (arguments passed in integer registers).
A pure softfloat configuration would be --with-float=soft.

-- 
M?ns Rullg?rd
mans at mansr.com
