From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 26 Jul 2012 09:59:13 +0800
Subject: [GIT PULL] clk: changes for v3.6
In-Reply-To: <CAJOA=zN7ss05iRPAHf6Nh6exgvEq-yADnAPpO1d5pg+nnPnfVw@mail.gmail.com>
References: <20120724224951.GB3220@gmail.com>
 <CAGsJ_4xxa2TvS0ZQOSLJuQ7qiDuM1epN3cTjYqV5jkT=7UZrOg@mail.gmail.com>
 <CAJOA=zN7ss05iRPAHf6Nh6exgvEq-yADnAPpO1d5pg+nnPnfVw@mail.gmail.com>
Message-ID: <CAGsJ_4y2HCf0qA2j6O1cXYPJsD7o2aVR0PJ5+yB7-oRgvc6wPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

2012/7/26 Turquette, Mike <mturquette@ti.com>:
> Hi Barry,
>
> I did not forget it.  I think there was some miscommunication around
> what you wanted me to merge and it was all too close to the merge
> window.  I like to have a week-long buffer for clk-next to sit in
> linux-next without any changes leading up to the merge window.
>
> I'm happy to take your patches after 3.6-rc1.  Can you please re-send
> them after Linus publishes that tag?

ok. let's do it againest 3.6-rc1.

>
> Thanks much,
> Mike
>
> On Tue, Jul 24, 2012 at 7:57 PM, Barry Song <21cnbao@gmail.com> wrote:
>> Hi Mike,
>> did you forget merging:
>>
>> ARM: PRIMA2: convert to common clk and finish full clk tree
>> clk: prima2: move from arch/arm/mach to drivers/clk
>>
>> then we have to wait next merge window ?
>>
>> 2012/7/25 Mike Turquette <mturquette@ti.com>:
>>> Hi Linus,
>>>
>>> Here is the new stuff for the common clk framework.  It is made up of
>>> roughly equal parts core framework enhancements, platform ports and new
>>> exciting Device Tree bindings.
>>>
>>> Thanks much,
>>> Mike
>>>
>>>
>>> The following changes since commit bd0a521e88aa7a06ae7aabaed7ae196ed4ad867a:
>>>
>>>   Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.linaro.org/people/mturquette/linux.git tags/clk-for-linus
>>>
>>> for you to fetch changes up to 137f8a7213d80c1388ca48280c1ef0856b6fec30:
>>>
>>>   clk: fix compile for OF && !COMMON_CLK (2012-07-19 14:07:56 -0700)
>>>
>>> ----------------------------------------------------------------
>>> The common clk framework changes for 3.6 include a small number of core
>>> framework improvments, platform ports and new DT bindings.
>>>
-barry
