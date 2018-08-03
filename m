From: maxi.jourdan@wanadoo.fr (Maxime Jourdan)
Date: Fri, 3 Aug 2018 23:47:51 +0200
Subject: [PATCH 1/4] soc: amlogic: add meson-canvas driver
In-Reply-To: <CALecT5i1mnkvi4WuL701cA+UnRL9CKmj=CMqLEWN=fpbxfi7ZQ@mail.gmail.com>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
 <20180801185128.23440-2-maxi.jourdan@wanadoo.fr>
 <CALecT5i1mnkvi4WuL701cA+UnRL9CKmj=CMqLEWN=fpbxfi7ZQ@mail.gmail.com>
Message-ID: <CAHStOZ5W+jJRox3=Nnem+Z1zopFOUenpmT-QkUzd5hrmKXfX5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yixun, thanks for the review

2018-08-03 16:14 GMT+02:00 Yixun Lan <yixun.lan@gmail.com>:
>> +config MESON_CANVAS
>> +       bool "Amlogic Meson Canvas driver"
> shouldn't this a 'tristate'? since you'd make the driver a kernel module..

Yep it should!

I well noted your other feedback and v2 will have fixes for them :) .
