From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Mon, 14 Sep 2009 03:11:11 +0300
Subject: 'bx lr' vs 'mov pc,lr'
In-Reply-To: <20090913225835.GB30169@n2100.arm.linux.org.uk>
References: <94a0d4530909131455x7a33cbaaw402642fb2e63c6d6@mail.gmail.com>
	<20090913225835.GB30169@n2100.arm.linux.org.uk>
Message-ID: <94a0d4530909131711hf068509x900f19b5dfe8141d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2009 at 1:58 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Sep 14, 2009 at 12:55:24AM +0300, Felipe Contreras wrote:
>> I noticed that in 'arch/arm/lib/delay.S' we are using 'mov pc, lr'
>> instead of 'bx lr'. Why? It looks like 'mov pc, lr' is used all over
>> the place, but I can't find out what's the reason.
>
> Why do you want bx? ?bx isn't available on older CPUs.

Isn't it faster? I don't know if it would make sense to try it on newer CPUs.

-- 
Felipe Contreras
