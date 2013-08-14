From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 14 Aug 2013 16:20:09 -0400 (EDT)
Subject: [PATCHv3 2/5] arm64: factor out spin-table boot method
In-Reply-To: <CAOesGMhOgYL0_M7HS1CUqG0mfg3Oa_E5MNyzs2pnfVCd2PRAUw@mail.gmail.com>
References: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
 <1376497228-20543-3-git-send-email-mark.rutland@arm.com>
 <CAOesGMhOgYL0_M7HS1CUqG0mfg3Oa_E5MNyzs2pnfVCd2PRAUw@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1308141616340.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Aug 2013, Olof Johansson wrote:

> On Wed, Aug 14, 2013 at 9:20 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > With PSCI (and possibly other future boot methods), we can bring CPUs
> 
> That's a loaded statement.  :) What's being planned besides PSCI in
> the future? I thought PSCI was going to be mandated on all (new) arm64
> platforms?

Please let's get real.  PSCI is a "recommendation" spec.  It requires 
either a HYP or secure mode in the hardware which some vendors might 
decide not to implement.


Nicolas
