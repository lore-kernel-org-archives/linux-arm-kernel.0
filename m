From: olof@lixom.net (Olof Johansson)
Date: Wed, 14 Aug 2013 12:21:00 -0700
Subject: [PATCHv3 2/5] arm64: factor out spin-table boot method
In-Reply-To: <1376497228-20543-3-git-send-email-mark.rutland@arm.com>
References: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
 <1376497228-20543-3-git-send-email-mark.rutland@arm.com>
Message-ID: <CAOesGMhOgYL0_M7HS1CUqG0mfg3Oa_E5MNyzs2pnfVCd2PRAUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 9:20 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> With PSCI (and possibly other future boot methods), we can bring CPUs

That's a loaded statement.  :) What's being planned besides PSCI in
the future? I thought PSCI was going to be mandated on all (new) arm64
platforms?


-Olof
