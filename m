From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 4 Aug 2017 12:09:22 +0800
Subject: [linux-sunxi] [PATCH 05/10] clk: sunxi-ng: h3: gate then ungate
 PLL CPU clk after rate change
In-Reply-To: <CAGb2v66jK+iAbKVsv6=4tb0470KBdwU+AHjWDnWwKKTY+U+W6g@mail.gmail.com>
References: <20170723102749.17323-1-icenowy@aosc.io>
 <20170723102749.17323-6-icenowy@aosc.io>
 <CAGb2v66jK+iAbKVsv6=4tb0470KBdwU+AHjWDnWwKKTY+U+W6g@mail.gmail.com>
Message-ID: <CAGb2v67LWirnWuQzzkNx4MU6Z-pERJBr6vcVfdoddFwLC=FXoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 3:14 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Sun, Jul 23, 2017 at 6:27 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> From: Chen-Yu Tsai <wens@csie.org>
>>
>> This patch utilizes the new PLL clk notifier to gate then ungate the
>> PLL CPU clock after rate changes. This should prevent any system hangs
>> resulting from cpufreq changes to the clk.
>>
>> Reported-by: Ondrej Jirman <megous@megous.com>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> Tested-by: Icenowy Zheng <icenowy@aosc.io>
>
> This is missing
>
> Fixes: 0577e4853bfb ("clk: sunxi-ng: Add H3 clocks")

Applied for 4.14 with the Fixes tag and Stephen's ack.
