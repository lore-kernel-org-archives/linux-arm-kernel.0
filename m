From: otavio.salvador@ossystems.com.br (Otavio Salvador)
Date: Mon, 26 Nov 2018 11:36:01 -0200
Subject: [PATCH 08/13] ARM: dts: rv1108: Fix the PMU interrupt number
In-Reply-To: <3361921.c4PKPBIJKP@phil>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
 <20181125211907.9895-8-otavio@ossystems.com.br> <3361921.c4PKPBIJKP@phil>
Message-ID: <CAP9ODKrX__KXo-XEdoaL=qwALFAxyzKV4-xu_t5baMqN1kQH4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Heiko,

On Mon, Nov 26, 2018 at 3:59 AM Heiko Stuebner <heiko@sntech.de> wrote:
> Am Sonntag, 25. November 2018, 22:19:02 CET schrieb Otavio Salvador:
> > According to the Rockchip vendor tree the PMU interrupt number is
> > 76, so fix it accordingly.
> >
> > Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> > Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>
>
> looks ok, especially as the TRM I have doesn't list neither irqs :-)
> But please explain the second Signed-off by Fabio?
>
> If Fabio is the original author, the patch From should reflect that
> and the Signed-off-by lines should be swapped. As it is now
> I would expect Fabio being the one sending the patches.
> Or is it supposed to be a "Co-developed-by:"?
> See Documentation/process/5.Posting.rst.

He works with me and he applied and tested it in our internal tree for
our customer. He reviewed and tested this with me, so I'd like to
provide him credit as well.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
