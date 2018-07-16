From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Jul 2018 09:26:31 +0200
Subject: [GIT PULL] Rockchip dts32 fix for 4.18
In-Reply-To: <1884349.WTgIHKSUBb@phil>
References: <1776596.Q4iCTXTKyP@phil>
 <20180714221105.u7gbyetcpjhlylfl@localhost>
 <1884349.WTgIHKSUBb@phil>
Message-ID: <CAK8P3a2Rxh2L2FyZ_dVx1ruLAcUni3WGwQP39M3mLCCvTxkM3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 15, 2018 at 5:46 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Am Sonntag, 15. Juli 2018, 00:11:05 CEST schrieb Olof Johansson:
>> On Wed, Jul 11, 2018 at 04:18:55PM +0200, Heiko Stuebner wrote:
>> > Hi Arnd, Kevin, Olof,
>> >
>> > please find below a one-patch pull fixing a new warning the updated dtc
>> > in 4.18 found. So far no other regressions have been found in Rockchip
>> > parts it seems. So please pull!
>> >
>> > Thanks
>> > Heiko
>> >
>> > The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>> >
>> >   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>> >
>> > are available in the Git repository at:
>> >
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.18-rockchip-dts32fixes-1
>> >
>> > for you to fetch changes up to cddb86833615d9550d7b3a1b65b71071784dae70:
>> >
>> >   ARM: dts: rockchip: fix graph node unit address error from dtc (2018-06-17 09:31:34 +0200)
>>
>> I took the liberty to declare this non-urgent and queued it up with next/dt
>> instead for 4.19. It's just a warning and we're past rc4 so it seemed like
>> a reasonable call. Let me know if it has actual functional impact/regression
>> though.
>
> no problem from my side, it's just dtc emiting the warning :-)
>
> I just saw this the first time with 4.18-rc1, so it seems to stem from
> a newer dtc and remembered that previous dtc fixes from Arnd or so
> went in as fixes.

Right, I usually tried to get all warnings merged in the kernel release
that contains the dtc change so that we would remain warning free in an
allmodconfig build. If dtc gets changed for -next, then queuing the warning
fix for -next instead of as a fix is fine, but if dtc is already changed in
mainline, I would appreciate having the warning fixed before the release.

       Arnd
