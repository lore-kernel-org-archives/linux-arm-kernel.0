From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 14 Jul 2017 15:55:26 +0300
Subject: [PATCH 14/14] [media] fix warning on v4l2_subdev_call() result
 interpreted as bool
In-Reply-To: <CAK8P3a0f84OPcCK1r3P9inGYDJC2KaAO4mjE2vn+vCws-oo_bw@mail.gmail.com>
References: <20170714092540.1217397-1-arnd@arndb.de>
 <20170714093938.1469319-1-arnd@arndb.de>
 <20170714120512.ioe67nnloqivtbr7@mwanda>
 <CAK8P3a0f84OPcCK1r3P9inGYDJC2KaAO4mjE2vn+vCws-oo_bw@mail.gmail.com>
Message-ID: <20170714125525.kjemhcn4poon6r3i@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ah...  I see why it's complaining about these ones in particular...

I don't agree with it as a static analysis dev, and I don't like the
changes too much.  But since it's only generating a hand full of
warnings then I don't care.

regards,
dan carpenter
