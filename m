From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 14 May 2010 23:21:49 +0900
Subject: RMK closing tree to patches *this* weekend
In-Reply-To: <20100514092435.GD10339@n2100.arm.linux.org.uk>
References: <20100513230201.GA26822@n2100.arm.linux.org.uk>
	<AANLkTikMkO7wC5bmwZUHVX3_yPRkZCcOc8NyGp1zU_4i@mail.gmail.com>
	<20100514092435.GD10339@n2100.arm.linux.org.uk>
Message-ID: <AANLkTincGbDle7n-VhWQVMOMTFqRzV4Cfh9yTKokPViQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 6:24 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, May 14, 2010 at 09:58:01AM +0900, Jassi Brar wrote:
>> On Fri, May 14, 2010 at 8:02 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > As of the end of this coming weekend, I'll stop taking patches for the
>> > next merge window. ?I want to tidy up the lose ends which need sorting
>> > out and give it a decent outing in linux-next for about a week before
>> > the merge window opens.
>> >
>> > So if there's any patches I've missed, please follow up to this email.
>> Hi Russell,
>>
>> Would it be possible for you to merge the PL330 core driver in your tree?
>> If so, I would make sure the platform specific stuff get up via Ben Dooks'
>> tree in time.
>
> I looked at doing that, but it conflicts in arch/arm/common/Kconfig:
>
> patching file arch/arm/common/Kconfig
> Hunk #1 FAILED at 40.
> 1 out of 1 hunk FAILED -- saving rejects to file arch/arm/common/Kconfig.rej
>
> I think this is another place where having things sorted alphabetically
> would help, rather than appending things to the end. ?That said, because
> of the changes in the versatile branch, its going to cause merge conflicts
> (which are easier to deal with than a patch which won't apply.)
>
> Could you move the PL330 option to between ICST307 and SA1111 please?
I just moved Kconfig and Makefile entries for that and submitted again
as [6132/1]
thanks
