From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 23 Mar 2017 14:43:55 +0000
Subject: [RFC PATCH v2 38/41] arm64/sve: Detect SVE via the cpufeature
 framework
In-Reply-To: <20170323143704.GI3750@e103592.cambridge.arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
 <1490194274-30569-39-git-send-email-Dave.Martin@arm.com>
 <6466e33e-5d22-1a78-bacb-d9dc334ee6d7@arm.com>
 <20170323143704.GI3750@e103592.cambridge.arm.com>
Message-ID: <20170323144355.GJ3750@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 02:37:05PM +0000, Dave Martin wrote:
> On Thu, Mar 23, 2017 at 02:11:50PM +0000, Suzuki K Poulose wrote:

[...]

> > >The SVE field in AA64PFR0 is made visible visible to userspace MRS
> > >emulation.  This should make sense for future architecture
> > >extensions.
> > 
> > Please could you also update the following documentation :
> > 
> >  Documentation/arm64/cpu-feature-registers.txt
> 
> Missed that, thanks.
> 
> I'll propose a comment in this file reminding people to keep the
> document up to date too.

Scratch that, somebody beat me to it ;)

Cheers
---Dave
