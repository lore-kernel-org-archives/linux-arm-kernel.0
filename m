From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Apr 2012 16:22:46 +0100
Subject: [PATCH] Add the Performance Monitoring Unit to the Trimslice
 device tree
In-Reply-To: <4F9966CB.6090504@redhat.com>
References: <1330740413-29260-1-git-send-email-wcohen@redhat.com>
 <20120305103245.GC31189@mudshark.cambridge.arm.com>
 <4F9597B4.5020208@redhat.com> <4F9966CB.6090504@redhat.com>
Message-ID: <20120426152246.GI10272@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 04:16:27PM +0100, William Cohen wrote:
> On 04/23/2012 01:56 PM, William Cohen wrote:
> > Has this patch been pulled into the git tree?  -Will (Cohen)
> 
> 
> This patch pretty much duplicates what is already done for in board-seaboard.c:
> 
> http://lxr.linux.no/#linux+v3.3.3/arch/arm/mach-tegra/board-seaboard.c#L147
> 
> I have tested the patch out with oprofile, papi, and perf. Things seem to function properly with the patch on a trimslice.

Right, that sounds good to me. This should go via the tegra/arm-soc tree.
For some reason, I can't find the original patch in the list archives so
perhaps you could repost it to linux-arm-kernel and CC Olof and Arnd?

Cheers,

Will
