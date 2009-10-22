From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 22 Oct 2009 21:58:47 +0800
Subject: spitz backlight: fix brightness limiting
In-Reply-To: <20091022070527.GE2211@elf.ucw.cz>
References: <20091019213751.GC1482@ucw.cz>
	<f17812d70910211320s29d3aaa5tad3206df1e99e03b@mail.gmail.com>
	<20091022070527.GE2211@elf.ucw.cz>
Message-ID: <f17812d70910220658t5bbd5d02n5f4a37c1c7670cff@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2009 at 3:05 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Thu 2009-10-22 04:20:34, Eric Miao wrote:
>> It's a little bit weird it's called 'limit_mask' when I first converted it
>> to a spi driver. There must be some reasons, Richard, you've got
>> any ideas?
>
> Yes, the code was "interesting"...
>
> I can certainly do the rename, but maybe we can fix the issue now and
> do futher cleanups later?

Fair enough, I'm fine with that - I'd like this to go through Richard's
backlight tree if possible, though.
