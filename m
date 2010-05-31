From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 31 May 2010 10:18:03 +0900
Subject: [PATCH 05/15] ARM: S5P6442: Change to using
	s3c_gpio_cfgpin_range()
In-Reply-To: <20100531010907.GO7248@trinity.fluff.org>
References: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
	<1275026212-27510-6-git-send-email-ben-linux@fluff.org>
	<AANLkTilPCk0NqJ7od6ZBorqPrlG0xCjdPaim1Q3WwZMH@mail.gmail.com>
	<20100531010907.GO7248@trinity.fluff.org>
Message-ID: <AANLkTikp-Zaj1LsBlLK1BhvhxfCXbtMyB5KxsUd-I8HN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 31, 2010 at 10:09 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Fri, May 28, 2010 at 03:24:02PM +0900, Kyungmin Park wrote:
>> Hi,
>>
>> Looks good but I'm afraid it's more difficult to find pin
>> configuration from typo.
>
> Do you meant that there's now no explicit mention of all pins invovled?

When develop new device drivers, developers can be give wrong pin
number easily so can't find a what's the problem.

So how about to add sysfs which pins have function number to check it easily?

>
> Note, may decided to drop or re-do this series.

I vote for working continuously .

Thank you,
Kyungmin Park
