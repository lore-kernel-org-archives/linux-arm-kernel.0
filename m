From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 1 Aug 2015 00:24:39 +0200
Subject: [PATCH 23/23] clk: at91: Revert "keep slow clk enabled to
 prevent system hang"
In-Reply-To: <55BBE9E1.4010707@codeaurora.org>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1438335599-3301-24-git-send-email-alexandre.belloni@free-electrons.com>
 <55BBC5CC.80406@codeaurora.org> <20150731210905.GM27985@piout.net>
 <55BBE47F.3010307@codeaurora.org>
 <20150731212724.GN27985@piout.net>
 <55BBE9E1.4010707@codeaurora.org>
Message-ID: <20150731222439.GO27985@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/2015 at 14:34:25 -0700, Stephen Boyd wrote :
> Ok that's fine. I added clk.h into this file when I removed clk.h from
> clk-provider.h so that it keeps compiling. Please remind us to pick this up
> when you think it's ready.
> 

Ah right, then I'll try to remember to remove it before resending.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
