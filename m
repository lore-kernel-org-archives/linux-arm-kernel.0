From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 21 Oct 2012 23:11:43 +0200
Subject: [RFC 00/11] Convert Kirkwood to pinctrl
In-Reply-To: <20121021191634.GL21046@lunn.ch>
References: <1350745663-5277-1-git-send-email-andrew@lunn.ch>
 <20121021210902.4dbd3e09@skate> <20121021191634.GL21046@lunn.ch>
Message-ID: <5084650F.9050208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2012 09:16 PM, Andrew Lunn wrote:
>>> Do we want to enable the use of mvebu GPIO driver
>>> outside of mach-mvebu?
>>
>> Yes.
>>
>>> Do we want to enable the use of mvebu pinctrl driver
>>> outside of mach-mvebu?
>>
>> Yes.
>>
>> Generally speaking, I think it is a good idea for
>> mach-{mvebu,kirkwood,dove,mv78xx0,orion5x} to share as much
>> infrastructure code as possible.
>
> Definitely.
>
> However, i _think_ Sebastian had a different opinion to your two
> yes's. Maybe its just for Dove?
>
> I hope Sebastian will comment soon.

Andrew, Thomas,

we had long discussions about this some time ago. I agree to both
of Thomas' "yes" above as you convinced me that this is the best
way of merging plat-orion and mach-mvebu.

Do you want to add dove pinctrl to your patch set? If yes, when
do you want to post v1 of this RFC?

Sebastian
