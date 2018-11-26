From: otavio.salvador@ossystems.com.br (Otavio Salvador)
Date: Mon, 26 Nov 2018 11:45:16 -0200
Subject: [PATCH 07/13] ARM: dts: rv1108: Fix the timer mask
In-Reply-To: <4443441.F7S2jYBxxL@phil>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
 <20181125211907.9895-7-otavio@ossystems.com.br> <4443441.F7S2jYBxxL@phil>
Message-ID: <CAP9ODKoFaUP3JyY=x-6H-b_SZnN3BTtS5dMVsqE2-n96AWp2dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 3:27 AM Heiko Stuebner <heiko@sntech.de> wrote:
> Am Sonntag, 25. November 2018, 22:19:01 CET schrieb Otavio Salvador:
> > As done in the Rockchip vendor tree and also on other
> > "arm,armv7-timer" instances, the correct GIC_CPU_MASK_SIMPLE mask
> > is 4 instead of 1.
>
> Nope. That value represents the number of cores in the system.
> As the rv1108 only has one core, that should likely stay as it is.

I see, I will drop it for v2.

> Also, it seems I only got patches 6-13 what happened to 1-5?

It went to other mailing lists, I think. I will add you on Cc to all for v2.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
