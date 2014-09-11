From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Sep 2014 15:10:37 +0200
Subject: [GIT PULL] ARM: LPC32xx: Device tree updates
In-Reply-To: <13599998.oE5Dh5uM3r@wuerfel>
References: <541058F7.8060809@antcom.de>
	<13599998.oE5Dh5uM3r@wuerfel>
Message-ID: <CACRpkda=ywwvJ+Lc-aHsAS=w+8wOu9dA=1-3oCnr3zCezHStWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 6:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 10 September 2014 15:58:15 Roland Stigge wrote:
>> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
>>
>>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
>>
>> are available in the git repository at:
>>
>>   git://git.antcom.de/linux-2.6 lpc32xx/dt
>>
>> for you to fetch changes up to 280f965674dbc5090147724d90b701f2b81f07e3:
>>
>>   ARM: LPC32xx: Use DMA for both SSP channels (2014-09-10 15:41:30 +0200)
>>
>> ----------------------------------------------------------------
>> Roland Stigge (1):
>>       ARM: LPC32xx: Use DMA for both SSP channels
>>
>>  arch/arm/boot/dts/lpc32xx.dtsi | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> This unfortunately uses a binding for pl08x that hasn't been reviewed
> yet, so I can't pull it. See below for an illustration of how I think
> the binding should work. There are probably bugs in that code, but
> hopefully it's not too far off.

I have a more complete PL08x DT binding which includes defining
all signals etc. I will kick my own butt to get it out tonight or so so
you can compare it with this.

I think Russell want to be involved in reviewing this, his input was
very important when I defined my bindings.

Yours,
Linus Walleij
