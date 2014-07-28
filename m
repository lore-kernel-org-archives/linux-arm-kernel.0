From: benoitm@perenite.com (Benoit Masson)
Date: Mon, 28 Jul 2014 16:13:59 +0200
Subject: [PATCH 2/2] V4 ARM: mvebu: Added dts defintion for Lenovo Iomega
 ix4-300d NAS
In-Reply-To: <20140728140805.GQ23220@titan.lakedaemon.net>
References: <1406503839-4662-1-git-send-email-yahoo@perenite.com>
 <20140728140805.GQ23220@titan.lakedaemon.net>
Message-ID: <02CE8576-5CD8-4AA5-971E-85CBC8CE05D3@perenite.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Le 28 juil. 2014 ? 16:08, Jason Cooper <jason@lakedaemon.net> a ?crit :

> Benoit,
> 
> On Sun, Jul 27, 2014 at 04:30:39PM -0700, Benoit Masson wrote:
>> The Lenovo Iomega ix4-300d is a 4-Bay sata NAS with dual Gb,
>> USB2.0 & 3.0, powered by a Marvell Armada XP MV78230 dual core CPU.
>> 
>> http://shop.lenovo.com/us/en/servers/network-storage/lenovoemc/ix4-300d/
>> Signed-off-by: Benoit Masson <yahoo@perenite.com>
>> ---
>> arch/arm/boot/dts/Makefile                      |   3 +-
>> arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 285 ++++++++++++++++++++++++
>> 2 files changed, 287 insertions(+), 1 deletion(-)
>> create mode 100644 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
> 
> I've applied this to mvebu/dt with a few minor fixups.
> 
>  - Insert empty line between URL and S-o-B
>  - Removed i2c compatible property
>  - Removed trailing whitespace from multi-line comment at end of file
> 
> Also, traditionally, the 'V4' goes inside the square brackets, eg
> 
>  [ PATCH V4 2/2 ] ...
> 
> This is done because 'git am ...' automagically removes everything
> between the square brackets and then takes the rest of the subject line
> to be the first line of the commit message.
> 
> Well done!

Thanks Jason and all for supporting this and following up long discussions on A0 stepping ... !

Just one question is how would you link this patch to the quirk a0 patch since this patch can't work without it ...

> 
> You can view the commit here:
> 
>  http://git.infradead.org/linux-mvebu.git/commitdiff/40c2da45366171bdc9ad1968489aaae190248383
> 
> thx,
> 
> Jason.
