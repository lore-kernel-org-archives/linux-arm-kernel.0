From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 11 May 2015 22:18:40 +0200
Subject: [PATCH] Show proper respect for Heinrich Hertz by using the
 correct unit for frequency
In-Reply-To: <20150511190847.GE15563@atomide.com> (Tony Lindgren's message of
 "Mon, 11 May 2015 12:08:48 -0700")
References: <20150511131952.GD2067@n2100.arm.linux.org.uk>
 <20150511190847.GE15563@atomide.com>
Message-ID: <87pp66n9zz.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150511 06:23]:
>> The SI unit of frequency is Hertz, named after Heinrich Hertz, and is
>> given the symbol "Hz" to denote this.  "hz" is not the unit of frequency,
>> and is in fact meaningless.
>> 
>> Fix arch/arm to correctly use "Hz", thereby acknowledging Heinrich Hertz
>> contribution to the modern world.
>> 
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
