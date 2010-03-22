From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 22 Mar 2010 11:11:51 -0700
Subject: [RFC 17/18] arm: mm: Add SW emulation for ARM domain manager
	feature
In-Reply-To: <1264437609.6275.110.camel@pc1117.cambridge.arm.com>
References: <1263250057-26692-18-git-send-email-dwalker@codeaurora.org>
	<1264437609.6275.110.camel@pc1117.cambridge.arm.com>
Message-ID: <1269281511.31379.53.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-01-25 at 16:40 +0000, Catalin Marinas wrote:
> Hi Daniel,
> 
> On Mon, 2010-01-11 at 22:47 +0000, Daniel Walker wrote:
> > Do not set domain manager bits in cp15 dacr.  Emulate using SW.  Add
> > kernel hooks to handle domain changes, permission faults, and context
> > switches.
> 
> In case you were not aware, there's a patch around (I think since 2007)
> that removes the domain switching entirely from the kernel (given that
> they have been deprecated for some time and may disappear completely in
> the future):
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/005616.html
> 

I didn't find this in 2.6.34 ? Are you re-writing it? Why has it been
around so long out of mainline?

Daniel
