From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 15 May 2014 12:52:31 -0400 (EDT)
Subject: [PATCH v6 0/5] MCPM backend for Exynos5420
In-Reply-To: <CAM4voakB57mgyQmtkpCUAF1BVW5z3BGsesvxvTuSg_JwBh-sxw@mail.gmail.com>
References: <1399982324-27879-1-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1405131325060.980@knanqh.ubzr>
 <CAM4voanvVwj+FuWazTGMHMnM64Cw_qK03D3o=raS43f_zWFfog@mail.gmail.com>
 <alpine.LFD.2.11.1405140031490.980@knanqh.ubzr>
 <CAM4voa=6osyXYg_XF=XuGRYmxLDUO+5=-i+cMrNW92fzBZJjfA@mail.gmail.com>
 <alpine.LFD.2.11.1405140931380.980@knanqh.ubzr>
 <CAM4voam29e7aK7n86_Mpj-wwvkchm-e68qA5=iUFou+sUMONig@mail.gmail.com>
 <CAM4voakB57mgyQmtkpCUAF1BVW5z3BGsesvxvTuSg_JwBh-sxw@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1405151250070.17310@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 May 2014, Abhilash Kesavan wrote:

> Hi Nicolas,
> 
> On Wed, May 14, 2014 at 7:09 PM, Abhilash Kesavan
> <kesavan.abhilash@gmail.com> wrote:
> > Hi Nicolas,
> >
> > On Wed, May 14, 2014 at 7:03 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >> On Wed, 14 May 2014, Abhilash Kesavan wrote:
> >>
> >>> Hi Nicolas,
> >>>
> >>> [...]
> >>> >>
> >>> >> 1) can't create /sys/devices/system/cpu/cpu//online: nonexistent directory
> >>> >
> >>> > What do you get if you do:
> >>> >
> >>> > $ ls -d /sys/devices/system/cpu/cpu?/online
> >>> ls: /sys/devices/system/cpu/cpu//online: No such file or directory
> >>
> >> Somehow, you or your shell replaced the ? character into a / character.
> >> You could try with a * instead.
> > With a different RFS your script runs fine without any change. Will
> > update with results once testing is done.
> The script has been running for a few hours on my 5420 based
> chromebook. I can see all the cores being hotplugged in/out. A snippet
> of the prints, that I get on running the test, follows:
> 
[...]

Good, that looks pretty good.

Once you implement full cluster shutdown I can provide you with another 
script stressing that part.


Nicolas
