From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 19 Oct 2011 09:19:54 +0800
Subject: [PATCH v2] UART: add CSR SiRFprimaII SoC on-chip uart drivers
In-Reply-To: <20111018181319.GA7015@kroah.com>
References: <1318570799-3785-1-git-send-email-Barry.Song@csr.com>
	<CAGsJ_4w6fGH+G9KapHXzCwMhz_NKfPdCxs7rF5hWKw2LGUpwWA@mail.gmail.com>
	<20111018181319.GA7015@kroah.com>
Message-ID: <CAGsJ_4xJzL6dfSmmae8LH6kt2g1PmevgrFWgYLR3Tif8PD0bCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/19 Greg KH <greg@kroah.com>:
> On Tue, Oct 18, 2011 at 11:39:11AM +0800, Barry Song wrote:
>> 2011/10/14 Barry Song <Barry.Song@csr.com>:
>> > From: Rong Wang <Rong.Wang@csr.com>
>> >
>> > SiRFprimaII is the latest generation application processor from CSR?s
>> > multi-function SoC product family.
>> > The SoC support codes are in arch/arm/mach-prima2 from Linux mainline
>> > 3.0.
>> >
>> > There are three dedicated UARTs in system. This patch adds basic driver
>> > support for them.
>> >
>> > It has used the newest pinmux subsystem from Linus Walleij.
>>
>> Hi Alan, it means this patch doesn't compile until pinmux tree of
>> Linus Walleij is merged into mainline.
>> Now it is a linux next tree.
>
> So should it go through the pinmux tree? ?Or do you want to wait for the
> 3.3 kernel release to get this merged?

i think we can go ahead through Linux W's pinmux tree. Linus, would
you like to take care once Alan ack this.

>
> thanks,
>
> greg k-h

-barry
