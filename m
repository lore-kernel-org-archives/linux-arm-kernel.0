From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 18 Nov 2015 16:38:24 +0000
Subject: [PATCH v9 1/2] arm-soc: Import initial tango4 device tree
In-Reply-To: <564CA880.1030502@sigmadesigns.com> (Marc Gonzalez's message of
 "Wed, 18 Nov 2015 17:34:08 +0100")
References: <564C94A5.4060301@sigmadesigns.com>
 <564C94FD.60607@sigmadesigns.com> <yw1xr3jnfg2s.fsf@unicorn.mansr.com>
 <564CA880.1030502@sigmadesigns.com>
Message-ID: <yw1xmvubfekf.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> On 18/11/2015 17:05, M?ns Rullg?rd wrote:
>
>> Marc Gonzalez wrote:
>> 
>>> +		clkgen: clkgen at 10000 {
>>> +			compatible = "sigma,tango4-clkgen";
>>> +			reg = <0x10000 0x40>;
>>> +			clocks = <&xtal>;
>>> +			clock-output-names = "cpuclk", "sysclk";
>>> +			#clock-cells = <1>;
>>> +		};
>> 
>> Would you please consider using my clock driver that matches the actual
>> hardware, supports all the clock outputs required for USB, SATA, etc,
>> and works on tango3 as well?
>
> I was hoping to take baby steps to work up to a fully-functional port.
> The first step (in my mind) is this submission: a minimal port which
> only requires the two "main" clocks.
>
> The next step will add to the minimal port by supporting as many
> peripherals as possible, as well as their required clocks.

But the code already exists.  Why start over?

> Would you agree to discuss the clkgen driver in a few weeks, when I can
> concentrate full-time on the subject? Working on other drivers will give
> me a better understanding of the required clocks.

Perhaps it's premature to be pushing this as anything more than an RFC
at this stage.

-- 
M?ns Rullg?rd
mans at mansr.com
