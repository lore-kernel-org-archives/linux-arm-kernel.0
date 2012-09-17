From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 Sep 2012 08:20:36 +0900
Subject: [GIT PULL] Samsung fixes-3 for v3.6
In-Reply-To: <CAOesGMgu-me77fj85apd3X9SZvTPU5+EVD2MOWwuZoaCPF9cvQ@mail.gmail.com>
References: <05be01cd9527$b35c3480$1a149d80$%kim@samsung.com>
 <CAOesGMiJGihDWpQbgJo9FYSM8FF0WY-B4PtnbE2uWwJcjWzjUA@mail.gmail.com>
 <05c501cd9528$eb916fe0$c2b44fa0$%kim@samsung.com>
 <CAOesGMgu-me77fj85apd3X9SZvTPU5+EVD2MOWwuZoaCPF9cvQ@mail.gmail.com>
Message-ID: <05c801cd952b$0b48dfb0$21da9f10$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> Hi,
> 
> On Mon, Sep 17, 2012 at 4:05 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> 
> > Well...I don't think so, others also should be fixed before v3.6 because
> as
> > you can see, it can occur unexpected behavior and must be wrong. But
> last
> > one is small thing...
> 
> "ARM: EXYNOS: fixed SYSMMU setup definition to mate parameter name" is
> a valid cleanup, but it has zero functional impact, it just reorders
> two unused arguments to a stub macro.
> 
> "ARM: S3C24xx: delete double assignment" is a valid bugfix, but the
> bug was introduced in "ARM: S3C2410: H1940: Use leds-gpio driver for
> LEDs managing" in 2.6.39 so fixing it in 3.7 seems just as fine as
> 3.6, in my opinion -- it's gone unnoticed so far and was just found by
> tools.
> 
> "ARM: S3C24XX: removes unnecessary semicolon" fixes a harmless extra
> semicolon after a switch statement. Valid cleanup but definitely not
> urgent for 3.6.
> 
Agreed. Let me sort out the branch for fixes soon, then re-send pull
request.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
