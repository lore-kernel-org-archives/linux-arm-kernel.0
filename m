From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 25 May 2017 12:44:19 -0700
Subject: [PATCH] RFC: arm: eBPF JIT compiler
In-Reply-To: <CAHgaXdJPSemCoaRH_5wSEE6e7sOzPg7XChuWVvykbWia4meOMw@mail.gmail.com>
References: <1495564433-9750-1-git-send-email-illusionist.neo@gmail.com>
 <20170523204608.GG24807@lunn.ch>
 <CAHgaXdJH7VjS__KPOc1scN9d=wxzY0DEQHutiL3qhtQAWd-v-A@mail.gmail.com>
 <20170523232555.GY13759@lunn.ch>
 <CAHgaXdKn4J==r_22T3N_7O5oESd8xwL6L+Ot8nT9bGCsSjAkHw@mail.gmail.com>
 <20170525170051.GC18357@lunn.ch> <20170525172255.GF18357@lunn.ch>
 <CAHgaXd+CVrDEA=E2=23Qp6wk50=dBnFS6TiCtvphTBMjUywrGg@mail.gmail.com>
 <20170525182849.GG18357@lunn.ch>
 <CAHgaXdLCaTwaLiLsmkzWvzSa=67LzqwHkT6cS_CVUm9_8u2_2Q@mail.gmail.com>
 <20170525184809.GH18357@lunn.ch>
 <CAHgaXdJPSemCoaRH_5wSEE6e7sOzPg7XChuWVvykbWia4meOMw@mail.gmail.com>
Message-ID: <dc6d0a88-37e1-54dd-eecc-70989e997324@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/2017 12:09 PM, Shubham Bansal wrote:
> Hi Andrew,
> 
> On Fri, May 26, 2017 at 12:18 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> On Fri, May 26, 2017 at 12:05:23AM +0530, Shubham Bansal wrote:
>>> Hi Andrew,
>>>
>>> My Apologies.
>>>
>>> I will remove the #ifdef CONFIG_CPU_LITTLE_ENDIAN. Do you have the
>>> ARMv6 machine you can test it on?
>>
>> Sorry, i don't have a v6.
>>
>> Maybe try kzm with qemu-system-qemu?
> 
> I am afraid I not so familiar with qemu, otherwise I would have tried
> to test the code on ARMv5,6,7 myself.
> If you can help me with that it would be great, Otherwise I think I
> have to wait for someone to test it for ARMv6. Although, I am pretty
> sure it would work on that as it worked on ARMv5.

Using QEMU is far less complex than the patch you wrote, the tricky
point me be to find an ARMv6 root filesystem, unless you build the
module into the kernel and let it run its tests.
-- 
Florian
