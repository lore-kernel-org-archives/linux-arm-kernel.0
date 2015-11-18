From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Nov 2015 09:11:54 -0800
Subject: [PATCH v9 1/2] arm-soc: Import initial tango4 device tree
In-Reply-To: <yw1xmvubfekf.fsf@unicorn.mansr.com>
References: <564C94A5.4060301@sigmadesigns.com>
 <564C94FD.60607@sigmadesigns.com>
 <yw1xr3jnfg2s.fsf@unicorn.mansr.com>
 <564CA880.1030502@sigmadesigns.com>
 <yw1xmvubfekf.fsf@unicorn.mansr.com>
Message-ID: <CAOesGMjCw_DYB3OktnQvthqBAQxqeH6F0bXR-KW_36Y9sDh+fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 8:38 AM, M?ns Rullg?rd <mans@mansr.com> wrote:
> Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:
>
>> On 18/11/2015 17:05, M?ns Rullg?rd wrote:
>>
>>> Marc Gonzalez wrote:
>>>
>>>> +           clkgen: clkgen at 10000 {
>>>> +                   compatible = "sigma,tango4-clkgen";
>>>> +                   reg = <0x10000 0x40>;
>>>> +                   clocks = <&xtal>;
>>>> +                   clock-output-names = "cpuclk", "sysclk";
>>>> +                   #clock-cells = <1>;
>>>> +           };
>>>
>>> Would you please consider using my clock driver that matches the actual
>>> hardware, supports all the clock outputs required for USB, SATA, etc,
>>> and works on tango3 as well?
>>
>> I was hoping to take baby steps to work up to a fully-functional port.
>> The first step (in my mind) is this submission: a minimal port which
>> only requires the two "main" clocks.
>>
>> The next step will add to the minimal port by supporting as many
>> peripherals as possible, as well as their required clocks.
>
> But the code already exists.  Why start over?

M?ns, I don't understand your role in this. Can you clarify?

If you've already done a port, why haven't you contributed it
yourself? Why are you driving Marc's work from the back seat like this
instead of submitting your own work?

If Marc prefers to start with a minimal implementation, that's just
fine with me.


-Olof
