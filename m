From: cavokz@gmail.com (Domenico Andreoli)
Date: Mon, 16 Apr 2012 13:52:15 +0200
Subject: [PATCH] CLKDEV: Add helper routines to allocate and add clkdevs
 for given struct clk *
In-Reply-To: <20120416110254.GV24211@n2100.arm.linux.org.uk>
References: <cfe2a4ef4a7903696200ca3880b96b4aa98c4820.1334553491.git.viresh.kumar@st.com>
 <20120416102503.GA32687@glitch> <4F8BF4DD.2080501@st.com>
 <20120416103822.GU24211@n2100.arm.linux.org.uk>
 <20120416105648.GA414@glitch>
 <20120416110254.GV24211@n2100.arm.linux.org.uk>
Message-ID: <CADjby3WwxvFD7JfBQFdWo4mS6FGyXZ7Dqx1NoaUP+UW0e0TNxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2012 at 1:02 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Apr 16, 2012 at 12:56:48PM +0200, Domenico Andreoli wrote:
>> > I don't think these checks actually help anyone, especially if the user
>> > forgets to check the return value (which makes them silent errors.)
>> >
>> > If you're going to abuse the interface by passing a NULL clk_lookup or
>> > num=0 then you deserve to get a big fat oops to tell you that you messed
>> > up. ?Same for NULL dev_id and con_id above.
>>
>> I hope for a BUG_ON then.
>
> Would you also like all the standard functions such as strcpy() to also
> check for NULL pointers just in case you want it to copy your string to
> the NULL pointer as well?
>
> This is utterly rediculous. ?If your programming ability is soo poor that
> you need this kind of help (because you think you might abuse interfaces
> by doing really stupid stuff like passing NULL clk_lookup pointers to
> functions which can only ever take a valid pointer) then you shouldn't be
> touching the kernel.

ok, you are for the total removal. got it now.

thanks,
Domenico
