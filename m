From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 May 2013 09:43:50 +0800
Subject: [PATCH 1/3] ARM: dts: imx28-evk: Enable touchscreen support
In-Reply-To: <CAOMZO5DRuKrECnYDtZ0wOK6_vpW95Cwc3xf7LT+VT_B7eV3gug@mail.gmail.com>
References: <1360337803-19858-1-git-send-email-festevam@gmail.com>
 <20130304031716.GC30431@S2101-09.ap.freescale.net>
 <CAOMZO5Ai-msRVeAqQFiRhfAxkb2DMTYJvTcYihBhFt6GMCFwPQ@mail.gmail.com>
 <20130323135608.GG6281@S2101-09.ap.freescale.net>
 <CAOMZO5BvT3CUhPECTQZQq_Q2YEqMJzmXPL5pj-3Qmq35jnvm1A@mail.gmail.com>
 <20130324141758.GH6281@S2101-09.ap.freescale.net>
 <CAOMZO5AeJUtyRC1BoAUiFihbjKtLMC2WBjaUXW0x+RE+QHYPnA@mail.gmail.com>
 <20130514023142.GA16250@S2101-09.ap.freescale.net>
 <CAOMZO5DRuKrECnYDtZ0wOK6_vpW95Cwc3xf7LT+VT_B7eV3gug@mail.gmail.com>
Message-ID: <20130528014348.GA19608@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 27, 2013 at 09:52:21PM -0300, Fabio Estevam wrote:
> Hi Shawn,
> 
> On Mon, May 13, 2013 at 11:31 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > Have you tested it against v3.10-rc1?  The issue is still there in my
> > testing.
> 
> I am not able to see the issue on 3.10-rc2.
> 
My imx/dt branch is currently basing on v3.10-rc1, and I do not care if
it works on v3.10-rc2.  I have tested this patch enough on different
bases, and I'm not going to test it again and again to find a base which
happens to work.  I do not feel comfortable to merge this patch if it
only works on particular base.  Who knows if it will break again with
another random patches merged in.  There is some issue, and we need to
find the root cause of it instead of ignoring it by finding some random
base which hides it.

> What are the exact steps to trigger the problem? Do you see it consistently?

Before I answer your questions, can I ask if you have tried to reproduce
it on v3.10-rc1?

Shawn
