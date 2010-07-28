From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 28 Jul 2010 16:32:42 +0900
Subject: S5PC110 should be used the correct VIC number
In-Reply-To: <20100728072753.GC29277@n2100.arm.linux.org.uk>
References: <AANLkTikh7mt30gEQU0_Wr7n-jZrG0iUmd1Hw17Ni7UNQ@mail.gmail.com>
	<009d01cb2e1a$29605e80$7c211b80$%kim@samsung.com>
	<AANLkTinC_68244EXf2jcEQN8zur8Dff5AcVjA+UTiNPX@mail.gmail.com>
	<20100728072753.GC29277@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimbyuy3_iKzyDANaWM=Lbx9JRvGAm9CDHqkbZRn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 28, 2010 at 4:27 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jul 28, 2010 at 04:25:16PM +0900, Kyungmin Park wrote:
>> On Wed, Jul 28, 2010 at 3:00 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> > Kyungmin Park wrote:
>> >>
>> >> Hi Ben,
>> >>
>> >> Can you post the VIC patch from correct VIC number from vic code at
>> >> suspend & resume?
>> >> If not, it has to modify it after release. or can you fix it as below.
>> >>
>> > Yeah, you're right.
>> >
>> > Already reported by Ben Dooks...but missed that.
>> > http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/016872.html
>>
>> I think ben's patch solves all of problems.
>>
>> Russell, can you pull it from ben's tree?
>
> When and only when Ben sends me a pull request.
>
In my memory, you mentioned it. there's some missing related it during
merge windows when I sent the above patches. So above patch doesn't
accepted.

Then If Ben don't request it. can you accept the each SoCs fixed patches?

Thank you,
Kyungmin Park
