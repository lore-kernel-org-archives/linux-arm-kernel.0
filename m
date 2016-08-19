From: romain.perier@free-electrons.com (Romain Perier)
Date: Fri, 19 Aug 2016 16:39:24 +0200
Subject: [crypto] [marvell-cesa] Driver hangs on Armada 385 device
In-Reply-To: <20160819142145.GQ1041@n2100.armlinux.org.uk>
References: <57b6f38c.23012e0a.374a0.56c6@mx.google.com>
 <20160819141251.5dcc835d@free-electrons.com>
 <20160819130846.GN1041@n2100.armlinux.org.uk>
 <57B71301.4010005@free-electrons.com>
 <20160819142145.GQ1041@n2100.armlinux.org.uk>
Message-ID: <57B71A1C.3010607@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le 19/08/2016 16:21, Russell King - ARM Linux a ?crit :
> On Fri, Aug 19, 2016 at 04:09:05PM +0200, Romain Perier wrote:
>> I was, wondering, do you boot with a separated DTB or a legacy boot
>> (concatenated to the Image) ?
>>
>>
>> Could you test with uImage.armada-385-db-ap [1], that's a legacy Image.
>> Also, I have uploaded a minimalistic rootfs [2], if you want.
>>
>> 1. http://www.free-electrons.com/~romain/pub/cesa/uImage.armada-385-db-ap
>> 2. http://www.free-electrons.com/~romain/pub/cesa/rootfs.cpio.xz
>
> I assume you mean Thomas rather than myself, as I have only Clearfog
> platforms, which are all Armada 388.

Yep, sorry. I meant, the person who has issues with cesa, i.e 
radioconfusion at gmail.com :)

>
> I don't use uImage anymore, except with versions of uboot that are
> unable to support zImage booting.  Where zImage booting is supported,
> I'm always using a separated DTB.  Doing otherwise is insane IMHO.
>

That's just, we have several ways to boot our Marvell devices, including 
legacy or non legacy boots, uImage and zImage. Anyway,
that's not the point of my previous email.

Romain
-- 
Romain Perier, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
