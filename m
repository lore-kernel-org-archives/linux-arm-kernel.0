From: olof@lixom.net (Olof Johansson)
Date: Mon, 17 Jun 2013 10:04:51 -0700
Subject: [PATCH RESEND V2] ARM: dts: Correct the base address of
 pinctrl_3 on Exynos5250
In-Reply-To: <1a1601ce6b5a$6833d8a0$389b89e0$%kim@samsung.com>
References: <1371025425-480-1-git-send-email-padma.v@samsung.com>
 <1a1601ce6b5a$6833d8a0$389b89e0$%kim@samsung.com>
Message-ID: <20130617170451.GB28497@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 09:58:47PM +0900, Kukjin Kim wrote:
> Padmavathi Venna wrote:
> > 
> > This patch corrects the base address of pinctrl_3 on Exynos5250
> > platform.
> > 
> > Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> 
> (+ Olof)
> 
> Olof, there is no other fixes in my tree for v3.10 yet, so would be helpful
> if you could take this into fixes in arm-soc for v3.10. Just note, the wrong
> address added during v3.10 merge window.

Huh. I guess we lucked out on snow since we're definitely using this and didn't
hit any problems from it.

I'll apply to fixes.


-Olof
