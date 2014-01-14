From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 14 Jan 2014 15:56:40 -0800
Subject: [GIT PULL]ARM: sirf: dts update for 3.14
In-Reply-To: <CAGsJ_4yx=U2dQ6ZkGAtvEwUPdWRwotJae8Sk+g+gqczV0JEo0w@mail.gmail.com>
 (Barry Song's message of "Thu, 9 Jan 2014 20:20:06 +0800")
References: <CAGsJ_4yx=U2dQ6ZkGAtvEwUPdWRwotJae8Sk+g+gqczV0JEo0w@mail.gmail.com>
Message-ID: <87y52i3yo7.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Barry Song <21cnbao@gmail.com> writes:

> Hi Olof,
> The following changes since commit 374b105797c3d4f29c685f3be535c35f5689b30e:
>
>   Linux 3.13-rc3 (2013-12-06 09:34:04 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
> tags/sirf-dts-for-3.14
>
> for you to fetch changes up to 73f68c01f468f072776d98f6bbf7fb367a1f2540:
>
>   ARM: dts: SiRF: add pin group for USP0 with only RX or TX frame sync
> (2014-01-09 20:05:31 +0800)
>
> ----------------------------------------------------------------
> ARM: sirf: dts update for 3.14
>
> some missed dt nodes or props for sirf dts for 3.14.
> Among them:
>  - add lost clocks for cphifbg
>  - add lost bus_width, clock and status for sdhci
>  - add clock, frequence-voltage table for CPU0
>  - add lost minigpsrtc device node
>  - add lost usp1_uart_nostreamctrl pin group for atlas6
>  - add pin group for USP0 with only RX or TX frame sync
>
> ----------------------------------------------------------------

Pulled into next/dt.

Thanks,

Kevin
