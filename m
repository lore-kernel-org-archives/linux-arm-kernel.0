From: rob@landley.net (Rob Landley)
Date: Tue, 07 Oct 2014 12:10:58 -0500
Subject: [PATCH 05/44] mfd: as3722: Drop reference to pm_power_off from
 devicetree bindings
In-Reply-To: <54341BF1.9020001@gmail.com>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-6-git-send-email-linux@roeck-us.net>
 <543412F7.8040909@landley.net> <20141007163131.GE28835@roeck-us.net>
 <54341BF1.9020001@gmail.com>
Message-ID: <54341EA2.6010806@landley.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/14 11:59, David Daney wrote:
> On 10/07/2014 09:31 AM, Guenter Roeck wrote:
>> On Tue, Oct 07, 2014 at 11:21:11AM -0500, Rob Landley wrote:
>>> On 10/07/14 00:28, Guenter Roeck wrote:
>>>> Devicetree bindings are supposed to be operating system independent
>>>> and should thus not describe how a specific functionality is
>>>> implemented
>>>> in Linux.
>>>
>>> So your argument is that linux/Documentation/devicetree/bindings should
>>> not be specific to Linux. Merely hosted in the Linux kernel source
>>> repository.
>>>
>>> Well that's certainly a point of view.
>>>
>> Not specifically my argument, really, and nothing new either. But,
>> yes, I do
>> think that devicetree bindings descriptions should not include
>> implementation
>> details, especially since those may change over time (as is the case
>> here).
>>
> 
> I fully agree.
> 
> Many device trees come from outside the kernel (i.e. they are supplied
> by the system boot environment).  Obviously these device trees cannot be
> changed at the whim of kernel developers, *and* it is perfectly
> reasonable to think that software other than the Linux kernel will run
> on this type of system too.
> 
> So yes, it is really true, device trees are not a Linux kernel private
> implementation detail, they are really an external ABI that, although
> documented in the kernel source tree, cannot be changed in incompatible
> ways as time progresses.

Ah. Existing thing with backstory among the in-crowd, so I'll assume
"git subtree" was previously suggested and you had that discussion
already and decided against it.

Carry on,

Rob
