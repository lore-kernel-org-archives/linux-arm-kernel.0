From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 14 Feb 2017 21:05:37 +0100
Subject: [PATCHv2 2/3] clk: mvebu: adjust clock handling for the CP110
 system controller
In-Reply-To: <20170214185912.GT25384@codeaurora.org>
References: <1482316017-22154-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482316017-22154-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20161222001456.GX8288@codeaurora.org>
 <20170214162718.0777d95f@free-electrons.com>
 <20170214185912.GT25384@codeaurora.org>
Message-ID: <20170214210537.2c0218dd@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 14 Feb 2017 10:59:12 -0800, Stephen Boyd wrote:

> > I don't see my patch in clk-next at
> > https://git.kernel.org/cgit/linux/kernel/git/clk/linux.git/log/drivers/clk/mvebu/cp110-system-controller.c?h=clk-next,
> > nor in linux-next. Am I missing something?
> 
> Odd. I don't know what happened. I've applied it now.

I think you also forgot to apply:

  [PATCHv2 1/3] dt-bindings: arm: update Armada CP110 system controller binding

from the same series. You told me "Applied to clk-next", but I don't
see it in linux-next.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
