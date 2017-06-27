From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Jun 2017 09:36:09 +0200
Subject: next-20170626 build: 1 failures 1 warnings (next-20170626)
In-Reply-To: <1498481507.6075.10.camel@mtkswgap22>
References: <E1dPPgG-0002pe-3A@optimist>
 <20170626115653.e4xs4lk4paibuphx@sirena.org.uk>
 <1498481507.6075.10.camel@mtkswgap22>
Message-ID: <CAK8P3a31MDiyhvDhyfRG0EZFG7VfUpsy1J-=cJePHefvtWfadQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 2:51 PM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> On Mon, 2017-06-26 at 12:56 +0100, Mark Brown wrote:
>> On Mon, Jun 26, 2017 at 09:47:36AM +0100, Build bot for Mark Brown wrote:
>>
>> This build failure is still present in -next:
>>
>> >     arm-allmodconfig
>> > ../drivers/pci/host/pcie-mediatek.c:485:8: error: implicit declaration of function 'pci_register_host_bridge' [-Werror=implicit-function-declaration]
>>
>> and we're at -rc7 now.
>
> Hi Mark,
>
> This is due to we are in different branch but merge together...
>
> Anyway, I could send a critical patch, but I need Bjorn help to apply to
> -next. Seems he didn't response these days.
>
> Not sure how could I send it?

It's really something that Bjorn needs to fix by applying your patch,
but if he's currently not able to do that for some reason, a possible
workaround would be for either Stephen Rothwell to apply your fixup
on linux-next, or Andrew Morton to add it to his mmotm tree, either
way it will be part of linux-next and on top of the pci-next tree,
until Bjorn applies it.

Please re-send your patch to both of them, with Bjorn on Cc.

        Arnd
