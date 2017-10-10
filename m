From: tony@atomide.com (Tony Lindgren)
Date: Tue, 10 Oct 2017 13:33:25 -0700
Subject: [PATCH] ARM: head-common.S: Clear lr before jumping to
 start_kernel()
In-Reply-To: <CAMuHMdWH_pebSYAp04gmVceu3qqPczGaXS36R8CtzAYHo-CNog@mail.gmail.com>
References: <1507044184-27152-1-git-send-email-geert+renesas@glider.be>
 <nycvar.YSQ.7.76.1710031134140.5407@knanqh.ubzr>
 <CAMuHMdWJKQb5JY+diH=7dqNuypkPUqBeOEPSLOrfrnbfh2siRQ@mail.gmail.com>
 <CAMuHMdXpPfipmEdW0Dap6Pjwhz3QxLcrcbtU0RhCu721k-sBpA@mail.gmail.com>
 <CAMuHMdWH_pebSYAp04gmVceu3qqPczGaXS36R8CtzAYHo-CNog@mail.gmail.com>
Message-ID: <20171010203324.GX4394@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Geert Uytterhoeven <geert@linux-m68k.org> [171003 11:32]:
> On Tue, Oct 3, 2017 at 8:15 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Oct 3, 2017 at 8:11 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> On Tue, Oct 3, 2017 at 5:37 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >>> On Tue, 3 Oct 2017, Geert Uytterhoeven wrote:
> >>> Please send it to RMK's patch system.
> >>
> >> Done (I hope so ;-)
> >
> > Failed. Retrying.
> 
> Yiha ;-)
> 
> http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8702/1

This also fixes the spamming I started seeing with next-20171009:

Tested-by: Tony Lindgren <tony@atomide.com>
