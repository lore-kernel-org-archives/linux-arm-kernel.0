From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 30 Mar 2012 21:16:56 +0800
Subject: [PATCH] ASoC: fsl: enable ssi clock in probe function
In-Reply-To: <4F75AF20.6080009@freescale.com>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
 <20120329112949.GM3668@opensource.wolfsonmicro.com>
 <4F748751.3020300@freescale.com>
 <20120329160916.GG19506@S2101-09.ap.freescale.net>
 <4F748C8E.1010702@freescale.com>
 <20120330055543.GH19506@S2101-09.ap.freescale.net>
 <4F75AF20.6080009@freescale.com>
Message-ID: <CAAQ0ZWR5ws7od92bOcLn-kDdbSPAVRDQwdVu-90tRfDSH_49KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 March 2012 21:03, Timur Tabi <timur@freescale.com> wrote:
...
> You'll need to get Kumar Gala's ACK on that one, but if only the 8610 is
> broken, then I don't think he'll like it.
>
It's only about building in arch/powerpc/kernel/clock.c, which is a
pretty dummy clk API and does not take much cost.

Regards,
Shawn
