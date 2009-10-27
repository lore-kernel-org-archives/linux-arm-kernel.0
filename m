From: janboe.ye@gmail.com (ye janboe)
Date: Tue, 27 Oct 2009 22:41:46 +0800
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <20091027142858.GA22412@n2100.arm.linux.org.uk>
References: <1256123277.3851.36.camel@debian-nb>
	<20091025154416.GB1774@n2100.arm.linux.org.uk>
	<af3ea28a0910251959id60ad5kf95dd1f908fa55c9@mail.gmail.com>
	<200910271514.54506.jpihet@mvista.com>
	<20091027142858.GA22412@n2100.arm.linux.org.uk>
Message-ID: <af3ea28a0910270741t5aee5365tca3e12b382698c7b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

looks fine too. Thanks

2009/10/27 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Oct 27, 2009 at 03:14:53PM +0100, Jean Pihet wrote:
>> Russell, Janboe,
>>
>> On Monday 26 October 2009 03:59:23 ye janboe wrote:
>> > Sure. Russell
>> >
>> > After you restart_syscall patch are merged, I will send out another patch.
>> Here is what I ended up with after merging.
>> It has been tested on OMAP3 boards although I could not trigger the failing
>> put_user test case.
>>
>> What do you think?
>
> Looks fine, thanks.
>
