From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 5 Nov 2016 10:02:23 -0200
Subject: [GIT PULL] i.MX fixes for 4.9
In-Reply-To: <CAOMZO5D9uBBwWV8UJOLj-2iwWO6sReB5BAtzdi1q6OqbtvcSOQ@mail.gmail.com>
References: <20161024140622.GM30578@tiger>
 <CAOesGMhSHqs_WfxkdUn7yrT_9g1CO1cqXGzQ2Y1Y-+-tY1KNmw@mail.gmail.com>
 <CAOMZO5D9uBBwWV8UJOLj-2iwWO6sReB5BAtzdi1q6OqbtvcSOQ@mail.gmail.com>
Message-ID: <CAOMZO5Cna8o0u7bmKdbWxUsGghjc6WQB-HwO2mxuKX0yQhc-5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Mon, Oct 31, 2016 at 9:29 PM, Fabio Estevam <festevam@gmail.com> wrote:

> I think this will be fixed with this pcie-designware patch:
> http://www.spinics.net/lists/linux-pci/msg55244.html

Bjorn sent this fix to Linus, so we should be fine now.

>
>> Wandboard, has a peculiar MMC error. First I thought it was just the
>> card going bad, but now I'm not so sure since multi_v7 boots just fine
>> on the same hardware:
>
> Yes, I have been noticing this mmc error reported in your autobooter
> and I also thought it was some kind of a bad SD card.
>
> This particular error I have never been able to reproduce. Also
> checked kernelci and do not see this mmc error there.
>
> Interesting that it happens only with imx_v6_v7_defconfig and not with
> multi_v7_defconfig.

Today wandboard does not show the mmc error with imx_v6_v7_defconfig:
http://arm-soc.lixom.net/bootlogs/mainline/v4.9-rc3-376-gfb415f2/wandboard-arm-imx_v6_v7_defconfig.html

Looks like the mmc error come and go?
