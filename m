From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Jun 2017 16:22:23 +0200
Subject: [PATCH] arm64: ftrace: fix building without CONFIG_MODULES
In-Reply-To: <20170612124805.GA11581@arm.com>
References: <20170609102807.2992510-1-arnd@arndb.de>
 <20170609113850.GF13955@arm.com>
 <CAK8P3a10CQq3mvQzysTTk+y=WQ=zcXehjPDUXzqh8SnTZ6WkXg@mail.gmail.com>
 <20170612124805.GA11581@arm.com>
Message-ID: <CAK8P3a2pjsVztw81NA92wEwnqAMq83itYwJKfRTxT4q6AeC2Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 2:48 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Jun 09, 2017 at 08:57:31PM +0200, Arnd Bergmann wrote:
>> On Fri, Jun 9, 2017 at 1:38 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > I can't seem to reproduce this simply by disabling MODULES in defconfig.
>> > Could you share your .config, please?
>>
>> This is the randconfig I used: https://pastebin.com/SfKBY7f8
>
> Thanks, I was forgetting to enable ftrace. I think a simpler patch (and one
> that I can just apply via arm64) is switching the IS_ENABLEDs out for
> #ifdefs. See below.

Yes, good idea.

        Arnd
