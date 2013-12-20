From: tony@atomide.com (Tony Lindgren)
Date: Fri, 20 Dec 2013 08:16:22 -0800
Subject: [PATCHv11 07/49] clk: divider: add support for low level ops
In-Reply-To: <52B41E4B.8040808@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
 <1387452260-23276-8-git-send-email-t-kristo@ti.com>
 <20131219182620.GQ27438@atomide.com> <52B342D2.1010301@ti.com>
 <52B416E8.8070006@ti.com> <52B41C15.8040304@ti.com>
 <52B41E4B.8040808@ti.com>
Message-ID: <20131220161622.GC27438@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [131220 02:40]:
> 
> yeah, the crash was indeed when ll_ops was dereferenced despite being NULL.

Might be also worth checking if the gate and mux patches have a similar issue.

Regards,

Tony
