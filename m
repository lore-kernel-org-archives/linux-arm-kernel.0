From: vivien.didelot@savoirfairelinux.com (Vivien Didelot)
Date: Thu, 12 Jan 2017 21:34:59 -0500
Subject: [PATCH net-next v2 00/10] net: dsa: Support for pdata in dsa2
In-Reply-To: <20170112034121.27697-1-f.fainelli@gmail.com>
References: <20170112034121.27697-1-f.fainelli@gmail.com>
Message-ID: <87fuknpu0c.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

Florian Fainelli <f.fainelli@gmail.com> writes:

> Hi all,
>
> This is not exactly new, and was sent before, although back then, I did not
> have an user of the pre-declared MDIO board information, but now we do. Note
> that I have additional changes queued up to have b53 register platform data for
> MIPS bcm47xx and bcm63xx.
>
> Yes I know that we should have the Orion platforms eventually be converted to
> Device Tree, but until that happens, I don't want any remaining users of the
> old "dsa" platform device (hence the previous DTS submissions for ARM/mvebu)
> and, there will be platforms out there that most likely won't never see DT
> coming their way (BCM47xx is almost 100% sure, BCM63xx maybe not in a distant
> future).
>
> We would probably want the whole series to be merged via David Miller's tree
> to simplify things.
>
> Greg, can you Ack/Nack patch 5 since it touched the core LDD?
>
> Thanks!

I've tested this patchset on my mv88e6xxx (DTS) boards to make sure
nothing was broken, since it touches the driver. Looks good!

Tested-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Thanks,

        Vivien
