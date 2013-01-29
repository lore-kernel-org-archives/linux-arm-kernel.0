From: mikpe@it.uu.se (Mikael Pettersson)
Date: Tue, 29 Jan 2013 20:42:41 +0100
Subject: ixp4xx eth broken in 3.7.0/3.8-rc5?
Message-ID: <20744.9777.937924.822371@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When I try to update my ixp4xx machine to a 3.8-rc5 kernel it boots
Ok but the network (CONFIG_IXP4XX_ETH=y) fails to come up, with the
following in the kernel log:

net eth0: coherent DMA mask is unset

With a 3.7.0 kernel the situation is similar, except that the "net
eth0: coherent DMA mask is unset" message repeats itself endlessly
and I can't even get in on the serial console.

With the 3.6.0 kernel everything works perfectly.

I've (quickly) reviewed the ixp4xx changes from 3.6.0 to 3.7.0, but
nothing stands out.

Any ideas?

/Mikael
