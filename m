From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 14 Jul 2012 22:29:16 +0200
Subject: [PATCH] pinctrl: pinctrl-imx: only print debug message when DEBUG
 is defined
In-Reply-To: <20120712091206.GD22640@shlinux2.ap.freescale.net>
References: <1340273435-7530-1-git-send-email-b29396@freescale.com>
 <20120706091139.GA28264@shlinux2.ap.freescale.net>
 <20120712091206.GD22640@shlinux2.ap.freescale.net>
Message-ID: <CACRpkdZbboO=hrZK7B2pOLrwh+aqVfiC5y8zvJ5xzjtuBTfR9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2012 at 11:12 AM, Dong Aisheng <b29396@freescale.com> wrote:
> On Fri, Jul 06, 2012 at 05:11:40PM +0800, Dong Aisheng wrote:
>> On Thu, Jun 21, 2012 at 06:10:35PM +0800, Dong Aisheng wrote:
>> > From: Dong Aisheng <dong.aisheng@linaro.org>
>> >
>> > Fix regression for commit 3a86a5f8 (pinctrl: pinctrl-imx: free allocated
>> > pinctrl_map structure only once and use kernel facilities for IMX_PMX_DUMP)
>> > introduced in 3.5-rc3.
>> > With above commit, the debug code will alway be excuted.
>> > Change to excute it only when DEBUG is defined.
>> >
>> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
>> > ---
>> > Hopefully it can catch 3.5.
>> > ---
>> >  drivers/pinctrl/pinctrl-imx.c |    2 ++
>> >  1 files changed, 2 insertions(+), 0 deletions(-)
>> >
>> Ping.
>>
> Hi Linus,
>
> Can you help merge this?

OK applied it, we'll see if I can get it to Torvalds in time...

Yours,
Linus Walleij
