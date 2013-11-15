From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Nov 2013 11:36:12 +0000
Subject: [PATCH] ARM: nommu: Include asm/procinfo.h to fix build warning
In-Reply-To: <CAOesGMjh-bj=YsTQb=K0Hy4j_Wdc6rbueQ6+5oek9amwtE9UHA@mail.gmail.com>
References: <1384486680.11140.1.camel@phoenix>
 <CAOesGMjh-bj=YsTQb=K0Hy4j_Wdc6rbueQ6+5oek9amwtE9UHA@mail.gmail.com>
Message-ID: <20131115113612.GI16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 11:14:11PM -0800, Olof Johansson wrote:
> On Thu, Nov 14, 2013 at 7:38 PM, Axel Lin <axel.lin@ingics.com> wrote:
> > Include asm/procinfo.h to fix below build warning:
> >   CC      arch/arm/mm/nommu.o
> > arch/arm/mm/nommu.c:303:17: warning: 'struct proc_info_list' declared inside parameter list [enabled by default]
> > arch/arm/mm/nommu.c:303:17: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
> >
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> 
> This is identical to the patch I posted a day earlier, that I just
> sent to Russell's patch tracker. :)

And I probably have a near identical patch which I committed yesterday
morning.
