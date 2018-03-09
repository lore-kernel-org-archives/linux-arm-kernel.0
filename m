From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 9 Mar 2018 07:54:43 +0200
Subject: [PATCH v6 00/17] Rockchip ISP1 Driver
In-Reply-To: <CAFLEztT4XJ9QnvLciv62dFCfj-y7Kynd2R8HpVxXeUXObvp3GQ@mail.gmail.com>
References: <20180308094807.9443-1-jacob-chen@iotwrt.com>
 <20180308120200.wpcjnbglf4x32vrp@tarshish>
 <CAFLEztTokSaXJuN8Ls0BpAEuFdTC+Viwn6PGxC=TC6vZAs+w3g@mail.gmail.com>
 <20180309040903.hhkhylvs6q6lvqjy@tarshish>
 <CAFLEztT4XJ9QnvLciv62dFCfj-y7Kynd2R8HpVxXeUXObvp3GQ@mail.gmail.com>
Message-ID: <20180309055443.edcj2uvbc2s6bcoy@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

On Fri, Mar 09, 2018 at 01:05:28PM +0800, Jacob Chen wrote:
> 2018-03-09 12:09 GMT+08:00 Baruch Siach <baruch@tkos.co.il>:
> > On Fri, Mar 09, 2018 at 08:53:57AM +0800, Jacob Chen wrote:
> >> 2018-03-08 20:02 GMT+08:00 Baruch Siach <baruch@tkos.co.il>:
> >> > On Thu, Mar 08, 2018 at 05:47:50PM +0800, Jacob Chen wrote:
> >> >> This patch series add a ISP(Camera) v4l2 driver for rockchip rk3288/rk3399
> >> >> SoC.
> >> >>
> >> >> Wiki Pages:
> >> >> http://opensource.rock-chips.com/wiki_Rockchip-isp1
> >> >>
> >> >> The deprecated g_mbus_config op is not dropped in  V6 because i am waiting
> >> >> tomasz's patches.
> >> >
> >> > Which tree is this series based on? On top of v4.16-rc4 I get the build
> >> > failure below. The V4L2_BUF_TYPE_META_OUTPUT macro, for example, is not even
> >> > in media_tree.git.
> >>
> >> This series is based on v4.16-rc4 with below patch.
> >> https://patchwork.kernel.org/patch/9792001/
> >
> > This patch does not apply on v4.16-rc4. I also tried v2 of this patch with the
> > same result:
> >
> >   https://patchwork.linuxtv.org/patch/44682/
> 
> It need resolve merge conflict.
> 
> > Can you push your series to a public git repo branch?
> 
> Sure, I have push it to my github.
> https://github.com/wzyy2/linux/tree/4.16-rc4
> 
> This commit might be a bit of a mess
> https://github.com/wzyy2/linux/commit/ff68323c4804adc10f64836ea1be172c54a9d6c6

Thanks. This is very helpful.

I'm mostly interested in the tinkerboard, so the DT bits in your tree are also 
useful.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
