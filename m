From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 31 Mar 2015 10:20:52 +0200
Subject: [PATCH 1/2] drivers/rtc/rtc-s3c.c: Integrate Exynos3250 into
 S3C6410
In-Reply-To: <CABxcv==+h8R-tL9D5OXmYsuYfs_cLATViZ3N1veZwZBZF=fu0Q@mail.gmail.com>
References: <1427728773-29065-1-git-send-email-k.kozlowski@samsung.com>
 <1427728773-29065-2-git-send-email-k.kozlowski@samsung.com>
 <20150331002709.GF3849@piout.net>
 <CABxcv==+h8R-tL9D5OXmYsuYfs_cLATViZ3N1veZwZBZF=fu0Q@mail.gmail.com>
Message-ID: <20150331082052.GI3849@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 31/03/2015 at 08:49:39 +0200, Javier Martinez Canillas wrote :
> Hello Alexandre,
> 
> On Tue, Mar 31, 2015 at 2:27 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > nitpick: I would prefer rtc: rtc-s3c instead of drivers/rtc/rtc-s3c.c
> >
> 
> Yes but Krzysztof is following the convention used in drivers/rtc/
> which I think is the correct thing to do even when it's different from
> what is used all over the kernel.
> 

Having a look at the git history, the first and most used prefix is
actually 'rtc:' at some point, this started to change to 'drivers/rtc/'.
We should probably start to get back to 'rtc:', like most subsystems.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
