From: romain.perier@free-electrons.com (Romain Perier)
Date: Fri, 19 Aug 2016 16:19:03 +0200
Subject: [crypto] [marvell-cesa] Driver hangs on Armada 385 device
In-Reply-To: <57B71301.4010005@free-electrons.com>
References: <57b6f38c.23012e0a.374a0.56c6@mx.google.com>
 <20160819141251.5dcc835d@free-electrons.com>
 <20160819130846.GN1041@n2100.armlinux.org.uk>
 <57B71301.4010005@free-electrons.com>
Message-ID: <57B71557.5010903@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/08/2016 16:09, Romain Perier a ?crit :
> I was, wondering, do you boot with a separated DTB or a legacy boot
> (concatenated to the Image) ?
>
>
> Could you test with uImage.armada-385-db-ap [1], that's a legacy Image.
> Also, I have uploaded a minimalistic rootfs [2], if you want.
>
> 1. http://www.free-electrons.com/~romain/pub/cesa/uImage.armada-385-db-ap
> 2. http://www.free-electrons.com/~romain/pub/cesa/rootfs.cpio.xz

I have also uploaded the zImage and a separated DTB (the cesa directory 
can be read from your browser)

Romain
-- 
Romain Perier, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
