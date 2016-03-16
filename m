From: horms@verge.net.au (Simon Horman)
Date: Wed, 16 Mar 2016 14:36:21 +0900
Subject: [PATCH 2/3] arm64: dts: r8a7795: Add Cortex-A57 CPU cores
In-Reply-To: <56E8D6C6.2000306@rvc.renesas.com>
References: <1449236333-4410-1-git-send-email-dirk.behme@gmail.com>
 <1449236333-4410-2-git-send-email-dirk.behme@gmail.com>
 <20151211230751.GD6496@verge.net.au>
 <CANqRtoSeibffbaoVGV7Y_gyuXxCOu+1PmRf3imQ8OKhV6VoAMQ@mail.gmail.com>
 <566FD3EE.8040908@gmail.com> <20160316011901.GB23687@verge.net.au>
 <56E8D6C6.2000306@rvc.renesas.com>
Message-ID: <20160316053621.GA24138@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 10:45:10AM +0700, Khiem Nguyen wrote:
> Hi Simon, Dirk, Magnus,
> 
> On 3/16/2016 8:19 AM, Simon Horman wrote:
> >Hi Dirk,
> >
> >On Tue, Dec 15, 2015 at 09:48:46AM +0100, Dirk Behme wrote:
> >>On 15.12.2015 09:38, Magnus Damm wrote:
> >>>Hi Simon,
> >>>
> >>>On Sat, Dec 12, 2015 at 8:07 AM, Simon Horman <horms@verge.net.au> wrote:
> >>>>On Fri, Dec 04, 2015 at 02:38:52PM +0100, Dirk Behme wrote:
> >>>>>From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> >>>>>
> >>>>>Add Cortex-A57 CPU cores to r8a7795 SoC for a total of 4 x Cortex-A57.
> >>>>>
> >>>>>Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> >>>>>Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> >>>>>Sigend-off-by: Dirk Behme <dirk.behme@gmail.com>
> >>>>
> >>>>Thanks, I have queued this up for v4.5.
> >>>
> >>>Thanks. May I ask if CPU hotplug is known to work?
> >>
> >>
> >>I didn't test that.
> >
> >As a follow-up I am wondering if you subsequently observed CPU hotplug
> >working. My recent testing on v4.5 indicates that it isn't working in my
> >environment. It would be quite valuable to know if it has ever been known
> >to work.
> >
> >>>Also, which version
> >>>of the boot loader stack is required?
> 
> Yes. CPUHotplug will be supported in boot loader stack released by Dec 2015
> and later.

Thanks, that sounds positive.

As Dec 2015 has already passed I wonder if a boot loader stack that
supports CPU Hotplug is currently available. Perhaps internally?
If so I think it would be good to verify v4.5.

> >>I've the U-Boot / boot loader stack from BSP v3.0.2 on the board. I haven't
> >>tested v3.0.3, yet.
> >
> >For reference my environment is as follows:
> >
> >
> >     NOTICE:  BL2: R-Car H3 Loader Rev.1.0.1
> >     NOTICE:  BL2: DDR1600(rev.0.10)
> >     NOTICE:  BL2: DRAM Split is 4ch
> >     NOTICE:  BL2: QoS is Gfx Oriented(rev.0.24A)
> >     NOTICE:  BL2: v1.1(release):41099f4
> >     NOTICE:  BL2: Built : 11:47:26, Nov 19 2015
> >     NOTICE:  BL2: Normal boot
> >     NOTICE:  BL2: memdrv_block_read dst=0xe630e0b0 src=0x8180000 len=36(0x24)
> >     NOTICE:  BL2: memdrv_block_read dst=0x43f00000 src=0x8180400 len=3072(0xc00)
> >     NOTICE:  BL2: memdrv_block_read dst=0x44000000 src=0x81c0000 len=65536(0x10000)
> >     NOTICE:  BL2: memdrv_block_read dst=0x44100000 src=0x8200000 len=524288(0x80000)
> >     NOTICE:  BL2: memdrv_block_read dst=0x49000000 src=0x8640000 len=1048576(0x100000)
> >
> >     U-Boot 2015.04 (Nov 19 2015 - 11:47:49)
> >
> >     CPU: Renesas Electronics CPU rev 1.0
> >     Board: Salvator-X
> >     DRAM:  896 MiB
> >     MMC:   sh-sdhi: 0, sh-sdhi: 1, sh-sdhi: 2
> >     In:    serial
> >     Out:   serial
> >     Err:   serial
> >     Net:   ravb
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> >the body of a message to majordomo at vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 
> -- 
> Best regards,
> KHIEM Nguyen
> 
