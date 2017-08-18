From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Aug 2017 23:29:14 +0200
Subject: [GIT PULL] arm: mediatek: soc updates for v4.14
In-Reply-To: <CAK8P3a1ca44WqucCY0vTSpiKKnM7kHpAkRi29TdN9XN9FZCLgA@mail.gmail.com>
References: <9f782ba3-4c03-10a9-07c5-b2b682f81846@gmail.com>
 <CAK8P3a1ca44WqucCY0vTSpiKKnM7kHpAkRi29TdN9XN9FZCLgA@mail.gmail.com>
Message-ID: <CAK8P3a0hXrZ7CkE6hdGmY-E2DNvUuANRVZ3K8D=ix_p1-_QEiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 11:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Aug 17, 2017 at 3:27 PM, Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
>> ----------------------------------------------------------------
>> - add mt7623a smp support
>> - scpsys: reduce code duplication
>> - scpsys: add mt7622 support
>> - pmic wrapper: make of_device_ids constant
>
> Pulled into next/soc, thanks!

Upon second thought, I removed it again from next/soc and put it into
next/drivers instead.

      Arnd
