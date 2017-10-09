From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 9 Oct 2017 19:02:50 +0100
Subject: [PATCH v4 00/26] KVM/ARM: Add support for GICv4
In-Reply-To: <20171009175239.GE23730@char.us.oracle.com>
References: <20171006153401.5481-1-marc.zyngier@arm.com>
 <20171009175239.GE23730@char.us.oracle.com>
Message-ID: <63365b61-5a2e-220c-a543-d2245bd7f8a5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/17 18:52, Konrad Rzeszutek Wilk wrote:
> On Fri, Oct 06, 2017 at 04:33:35PM +0100, Marc Zyngier wrote:
>> This series implements full support for GICv4 in KVM, bringing direct
>> injection of MSIs to arm and arm64, assuming you have the right
>> hardware (which is quite unlikely).
>>
>> To get an idea of the design, I'd recommend you start with commit
>> 7954907bedaf as well as patch #26, which try to shed some light on the
>> approach that I've taken. And before that, please digest some of the
>> GICv3/GICv4 architecture documentation[1] (less than 800 pages!). Once
>> you feel reasonably insane, you'll be in the right mood to read the
> 
> You may want to update the link:
> 
> s/pfd/pdf/
> 
> (Does that mean you typed this by hand, my gosh, you really are breathing
> this everyday) :-)
I am, and I'm feeling pretty dizzy. You can't imagine the kind of fumes
this thing generates... ;-)

I probably copy/pasted the URL, edited something, messed up the URL,
fixed it (sort of), and ended posting the crap (twice!) without even
realizing. Oh well. I'll blame the spec, as always.

Thanks for the heads up!

	M.
-- 
Jazz is not dead. It just smells funny...
