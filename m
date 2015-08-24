From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 24 Aug 2015 17:25:16 +0800
Subject: [PATCH v2] watchdog: sunxi: fix activation of system reset
In-Reply-To: <20150726193238.GM2564@lukather>
References: <55B32BCE.5050506@gmail.com> <20150726193238.GM2564@lukather>
Message-ID: <CAGb2v66oZH_OifuUkzjJS3B5L-uBOaNMWZ7xhgF01EjrkuEq6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 27, 2015 at 3:32 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Jul 25, 2015 at 08:25:18AM +0200, Francesco Lavra wrote:
>> Commit f2147de33470 ("watchdog: sunxi: support parameterized compatible
>> strings") introduced a regression in sunxi_wdt_start(), by which
>> the system reset function of the watchdog is not enabled upon
>> starting the watchdog. As a result, the system is not reset when the
>> watchdog expires. Fix it.
>>
>> Signed-off-by: Francesco Lavra <francescolavra.fl@gmail.com>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> Fixes: f2147de33470 ("watchdog: sunxi: support parameterized compatible strings")
>> Cc: stable at vger.kernel.org
>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

What tree should this go in through?
Guenter, are you still taking watchdog patches?


Thanks
ChenYu
