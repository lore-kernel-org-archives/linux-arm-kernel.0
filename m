From: timur@freescale.com (Timur Tabi)
Date: Fri, 30 Mar 2012 08:19:44 -0500
Subject: [PATCH] ASoC: fsl: enable ssi clock in probe function
In-Reply-To: <CAAQ0ZWR5ws7od92bOcLn-kDdbSPAVRDQwdVu-90tRfDSH_49KA@mail.gmail.com>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
 <20120329112949.GM3668@opensource.wolfsonmicro.com>
 <4F748751.3020300@freescale.com>
 <20120329160916.GG19506@S2101-09.ap.freescale.net>
 <4F748C8E.1010702@freescale.com>
 <20120330055543.GH19506@S2101-09.ap.freescale.net>
 <4F75AF20.6080009@freescale.com>
 <CAAQ0ZWR5ws7od92bOcLn-kDdbSPAVRDQwdVu-90tRfDSH_49KA@mail.gmail.com>
Message-ID: <4F75B2F0.6090104@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
>> > You'll need to get Kumar Gala's ACK on that one, but if only the 8610 is
>> > broken, then I don't think he'll like it.
>> >
> It's only about building in arch/powerpc/kernel/clock.c, which is a
> pretty dummy clk API and does not take much cost.

Like I said, it needs Kumar's review.  You should ping him on it.  He may
just want the 8610 fixed.

-- 
Timur Tabi
Linux kernel developer at Freescale
