From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 02 Nov 2015 18:30:29 +0000
Subject: [PATCH v8 2/2] arm-soc: Add support for arm-based tango4 platforms
In-Reply-To: <20151102182615.GI2684@leverpostej> (Mark Rutland's message of
 "Mon, 2 Nov 2015 18:26:15 +0000")
References: <56377E76.2080209@sigmadesigns.com>
 <56377F09.6050805@sigmadesigns.com>
 <yw1xfv0o9xr3.fsf@unicorn.mansr.com>
 <20151102182615.GI2684@leverpostej>
Message-ID: <yw1x37wo9rui.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland <mark.rutland@arm.com> writes:

>> > +ENTRY(tango_smc)
>> > +	push	{lr}
>> > +	mov	ip, r1
>> > +	dsb
>> 
>> Did you ever get a straight answer on the dsb here?
>
> We didn't. Having a look just now, the earliest example appears to be
> in OMAP4 L2 support patches back in 2009 [1]. I was not able to find a
> rationale.

My guess is it was added out of frustration during early OMAP
development and forgotten.  Then it became cargo cult.

-- 
M?ns Rullg?rd
mans at mansr.com
