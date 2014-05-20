From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 20 May 2014 16:03:48 +0800
Subject: [GIT PULL]]ARM: sirf: dts update for 3.16
In-Reply-To: <CAGsJ_4waeAPJjnKiuXBJXXF-bYud=uO_j1hrS9auBAGr8KcFiQ@mail.gmail.com>
References: <CAGsJ_4waeAPJjnKiuXBJXXF-bYud=uO_j1hrS9auBAGr8KcFiQ@mail.gmail.com>
Message-ID: <CAGsJ_4zmAd+S_AKdfjCx0fF4SmgdjULKbKOa09-+r6E7CUyBsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-05-09 21:53 GMT+08:00 Barry Song <21cnbao@gmail.com>:
> Hi Arnd, Olof, Kevin,
>
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
>
>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
> tags/sirf-dts-for-3.16
>
> for you to fetch changes up to b01c5905c29d7d5748a24267bb2486e4a1605fda:
>
>   ARM: dts: sirf: add resets for dspif, gps and dsp nodes (2014-05-08
> 14:13:08 +0800)
>
> ----------------------------------------------------------------
> some minor cleanup and add some missed nodes:
> 1. move dma channel descriptions to generic dma properity;
> 2. add resets properity for some nodes;
> 3. add missed pinctrl groups.


Olof, i am not sure whether you missed this one as i forgot to CC
arm at kernel.org.


>
> ----------------------------------------------------------------
> Barry Song (1):
>       ARM: dts: sirf: move to use generic dma dt-binding for spi
>
> Rongjun Ying (1):
>       ARM: dts: sirf: add pin group for USP0 with only RX or TX frame
> sync for atlas6
>
> Tao Huang (1):
>       ARM: dts: sirf: add resets for dspif, gps and dsp nodes
>
> Ye He (1):
>       ARM: dts: atlas6: add cortex-a9-pmu compatible PMU node
>
>  arch/arm/boot/dts/atlas6.dtsi |   31 ++++++++++++++++++++++++++-----
>  arch/arm/boot/dts/prima2.dtsi |   10 ++++++----
>  2 files changed, 32 insertions(+), 9 deletions(-)
>
>

-barry
