From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Tue, 29 Jul 2014 17:06:59 +0900
Subject: [linux-3.10.17] Could not allocate memory from free CMA areas
In-Reply-To: <dsqnq2i1mer1r7kpvuflt0k9.1406214301636@email.android.com>
References: <dsqnq2i1mer1r7kpvuflt0k9.1406214301636@email.android.com>
Message-ID: <010401cfab04$1536b740$3fa425c0$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



From: pintu_agarwal [mailto:pintu_agarwal at yahoo.com] 
Sent: Friday, July 25, 2014 12:15 AM
To: PINTU KUMAR; linux-mm at kvack.org; linux-arm-kernel at lists.infradead.org; linaro-mm-sig at lists.linaro.org; iamjoonsoo.kim at lge.com; ritesh.list at gmail.com
Cc: pintu.k at outlook.com; pintu.k at samsung.com; vishu_1385 at yahoo.com; m.szyprowski at samsung.com; mina86 at mina86.com; ngupta at vflare.org; iqbalblr at gmail.com
Subject: RE: [linux-3.10.17] Could not allocate memory from free CMA areas

Dear joonsoo kim,

> I have your patches for: Aggressively allocate memory from cma ....
> We are facing almost similar problem here.
> If any of your patches still working for you please let us know here.
> I would like to try those approach.


Hello,

I stopped to implement it, because there are other bugs on CMA related codes.
Although aggressively allocate... doesn't have bugs itself, it enlarges
existing freepage counting bugs significantly so I'm first trying to fix
those bugs. See the below link.

https://lkml.org/lkml/2014/7/4/79

I will restart to implement aggressively... after fixing these bugs.

If you have interest on next version of aggressively allocate..., see the
following link.

https://github.com/JoonsooKim/linux/tree/cma-fix-up-v3.0-next-20140625

Thanks.
