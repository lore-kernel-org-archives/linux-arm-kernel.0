From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 19 Apr 2011 11:23:14 +0900
Subject: Cleanup Samsung stuff
In-Reply-To: <012801cbfe33$a76fa490$f64eedb0$%kim@samsung.com>
References: <012801cbfe33$a76fa490$f64eedb0$%kim@samsung.com>
Message-ID: <BANLkTimTuQ1YE8Xu04NyMZxF42KGDr_XBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 10:46 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Hi all,
>
> I think, you know about current situation of Linux ARM world.
>
> So...
>
> As Russell suggested, I also will focus on consolidations and bug fixes for
> Samsung stuff for a while so don't complain about missing new stuff. In my
> opinion, we can keep going it later...
>
> As a note, I'm doing(or preparing) following at the moment.
>
> - Removing some "mach-s5pxxxx"s
Why not mach-s3c series? don't you think too much plat-{s3c, s5p,
samsung}? how about to use the plat-samsung only?
> - Removing useless header files in include/{mach,plat} of Samsung
> - Samsung GPIO stuff cleanup/consolidation
> - Samsung DMA stuff consolidation?
   -> Move to dmaengine and use it.
> - Device tree (with Linaro)
> - and so on...

   - Strange Samsung Clock and names consolidation.
   - IRQ stuff (some parts are done by tglx but need to use the
generic IRQ base instead of odd +32 magic)
   - generic IOMMU consolidation.

BTW, who works on this at LSI?

Thank you,
Kyungmin Park
