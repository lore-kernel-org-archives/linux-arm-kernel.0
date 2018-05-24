From: philip.li@intel.com (Li, Philip)
Date: Thu, 24 May 2018 00:21:39 +0000
Subject: [rjarzmik:test/daniel 23/34] sound/arm/pxa2xx-ac97.c:27:10:
 fatal error: mach/regs-ac97.h: No such file or directory
In-Reply-To: <87lgcaxxy4.fsf@belgarion.home>
References: <201805231623.n3Qx9qdU%fengguang.wu@intel.com>
 <8545409a-475f-1821-fcef-60b2f85101b6@zonque.org>
 <831EE4E5E37DCC428EB295A351E662494CB31A1D@shsmsx102.ccr.corp.intel.com>
 <87lgcaxxy4.fsf@belgarion.home>
Message-ID: <831EE4E5E37DCC428EB295A351E662494CB32366@shsmsx102.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [rjarzmik:test/daniel 23/34] sound/arm/pxa2xx-ac97.c:27:10: fatal
> error: mach/regs-ac97.h: No such file or directory
> 
> "Li, Philip" <philip.li@intel.com> writes:
> 
> >> On Wednesday, May 23, 2018 10:46 AM, kbuild test robot wrote:
> >> > tree:   https://github.com/rjarzmik/linux test/daniel
> >> > head:   f495e2dbc482d8f01a1ee20e86284ee9c0c8fa98
> >> > commit: 4cd654b13b9bcc0f206d414497b798ed42df573a [23/34] HACK:
> select
> >> SND_PXA_SOC_SSP for SND_SIMPLE_CARD
> >>
> >> This patch is just a local hack in one of my scratch-pad branches and is
> >> not meant for upstream inclusion. Could you remove the branch or make
> >> sure it isn't picked up by test robots?
> > thanks for info, we will exclude it from testing.
> Hi Li, Philip,
> 
> Is it possible to exclude a pattern instead ?
> I mean would it be possible to exclude each branch of the form "test/*" ?
sure, we will use test/.* to match the branch to exclude.

> 
> Cheers.
> 
> --
> Robert
