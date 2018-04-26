From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Apr 2018 16:50:56 +0200
Subject: [PATCH] ARM: dts: Fix NAS4220B pin config
In-Reply-To: <39fa170a0b20c73c4ae45975202ead2f@advem.lv>
References: <20180417085311.13829-1-linus.walleij@linaro.org>
 <39fa170a0b20c73c4ae45975202ead2f@advem.lv>
Message-ID: <CAK8P3a0dfk32eaMVXraC53r=7q_-32V+_waJ49grkQCupFcxPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 10:33 PM, Roman Yeryomin <roman@advem.lv> wrote:
> On 2018-04-17 11:53, Linus Walleij wrote:
>>
>> The DTS file for the NAS4220B had the pin config for the
>> ethernet interface set to the pins in the SL3512 SoC while
>> this system is using SL3516. Fix it by referencing the
>> right SL3516 pins instead of the SL3512 pins.
>>
>> Cc: stable at vger.kernel.org
>> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
>> Reported-by: Andreas Fiedler <andreas.fiedler@gmx.net>
>> Reported-by: Roman Yeryomin <roman@advem.lv>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Tested-by: Roman Yeryomin <roman@advem.lv>

Applied to fixes, thanks!

        Arnd
