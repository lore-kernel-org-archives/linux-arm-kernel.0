From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 Aug 2010 09:33:02 +0100
Subject: smsc911x.c driver and SMP
In-Reply-To: <4C7C47DF.3030307@renesas.com>
References: <4C7C47DF.3030307@renesas.com>
Message-ID: <1283243582.28248.0.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-08-31 at 01:07 +0100, Shinya Kuribayashi wrote:
> On 10/6/2009 3:12 PM, Antti P Miettinen wrote:
> > Catalin Marinas <catalin.marinas@arm.com> writes:
> >> Fixed it with this new commit (I'm not posting the patch here as it's
> >> not meant for review on this list):
> >>
> >> http://www.linux-arm.org/git?p=linux-2.6.git;a=commitdiff;h=3cc8ee538f6727d1f6773fff6d8e31bc5522bfee
> >
> > Just a piece of information: with vanilla 2.6.31 boot from NFS root on
> > my PB11MPCore hangs, with this patch applied, boot succeeds.
> 
> Now I'm setting up similar dev environment by chance; Cortex-A9 MPcore,
> slightly old kernel (say .31 or .32), and with smsc911x.c Ethernet
> driver required [1].
> 
> I'm auditing the required patches right now, and very interested in
> above patch, but it seems that blob got lost these days :-(
> 
> Do you still have the patch, and would you mind sharing it with me?

It is in mainline already:

http://git.kernel.org/linus/492c5d943d6a04b124ba3a719dc746dc36b14cfb

-- 
Catalin
