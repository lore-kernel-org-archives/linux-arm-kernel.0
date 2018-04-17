From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 17 Apr 2018 14:12:33 +0100
Subject: [PATCH 1/2 v2] drm/pl111: Support the Versatile Express
In-Reply-To: <CACRpkdb1toYJEaHDZ2QORt+qzN7imH9ugx3xvi1HASoZU0QSiQ@mail.gmail.com>
References: <20180406141935.6801-1-linus.walleij@linaro.org>
 <20180410095737.GF10254@e110455-lin.cambridge.arm.com>
 <CACRpkdb1toYJEaHDZ2QORt+qzN7imH9ugx3xvi1HASoZU0QSiQ@mail.gmail.com>
Message-ID: <297aae18-8efc-b7cc-20c2-eb09d72d2dd1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/04/18 13:32, Linus Walleij wrote:
[...]
> Unfortunately there is just one single vexpress core tile in the
> upstream kernel that define a CLCD controller, the CA9 (4xA9)
> that I am using. All the others just use the MB CLCD.
> 
> I am thinking there is some never finished DTS upstreaming
> here that ought to happen so we use the core tile CLCD on some
> other boards as well.

Barring custom FPGA images, I think V2P-CA9 *is* the only VExpress tile 
implementing PL11x; all the more recent test chips had HDLCD instead.

Robin.
