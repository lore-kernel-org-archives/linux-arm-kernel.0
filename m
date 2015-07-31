From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 31 Jul 2015 23:09:05 +0200
Subject: [PATCH 23/23] clk: at91: Revert "keep slow clk enabled to
 prevent system hang"
In-Reply-To: <55BBC5CC.80406@codeaurora.org>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1438335599-3301-24-git-send-email-alexandre.belloni@free-electrons.com>
 <55BBC5CC.80406@codeaurora.org>
Message-ID: <20150731210905.GM27985@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/2015 at 12:00:28 -0700, Stephen Boyd wrote :
> On 07/31/2015 02:39 AM, Alexandre Belloni wrote:
> >-	clk_prepare_enable(slow_clk);
> >-
> >-	return 0;
> >-}
> >-arch_initcall(of_at91_clk_slow_retain);
> 
> Can you drop the include of clk.h in this file too?
> 

Sure! I will do that in v3. However, I'll wait for some feedback from
the other maintainers before sending again.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
