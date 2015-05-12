From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 12 May 2015 10:41:21 +0200
Subject: [PATCH v4 0/3] Add Mediatek SoC RTC driver
In-Reply-To: <CAGS+omArcu3caKZo56Db2u+84WAVJiMzkr+1uS6tr_zfwARQ7A@mail.gmail.com>
References: <1430897022-63357-1-git-send-email-eddie.huang@mediatek.com>
 <20150509130846.GD3338@piout.net>
 <CAGS+omArcu3caKZo56Db2u+84WAVJiMzkr+1uS6tr_zfwARQ7A@mail.gmail.com>
Message-ID: <20150512084121.GO3338@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/05/2015 at 16:15:13 +0800, Daniel Kurtz wrote :
> On Sat, May 9, 2015 at 9:08 PM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > On 06/05/2015 at 15:23:39 +0800, Eddie Huang wrote :
> >> RTC is one submodule of Mediatek MT6397 PMIC chip[1]. This series
> >> support RTC driver that work with Mediatek SoC like MT8135, MT8173.
> >> It implements second counter and also provide alarm function.
> >>
> >> This series base on 4.1-rc1, Test ok on MT8173 platform.
> >>
> >> [1] https://lkml.org/lkml/2015/1/23/325
> >>
> >
> > All applied, thanks!
> 
> To which git tree & branch did you apply these patches?
> 

They are in
git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next

They also landed in linux-next

I'll update the MAINTAINERS file to add the location of that git tree.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
