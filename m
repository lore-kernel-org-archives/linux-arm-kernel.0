From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 20 Dec 2013 18:33:33 +0200
Subject: [PATCHv11 07/49] clk: divider: add support for low level ops
In-Reply-To: <20131220161622.GC27438@atomide.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
 <1387452260-23276-8-git-send-email-t-kristo@ti.com>
 <20131219182620.GQ27438@atomide.com> <52B342D2.1010301@ti.com>
 <52B416E8.8070006@ti.com> <52B41C15.8040304@ti.com> <52B41E4B.8040808@ti.com>
 <20131220161622.GC27438@atomide.com>
Message-ID: <52B4715D.5020207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2013 06:16 PM, Tony Lindgren wrote:
> * Rajendra Nayak <rnayak@ti.com> [131220 02:40]:
>>
>> yeah, the crash was indeed when ll_ops was dereferenced despite being NULL.
>
> Might be also worth checking if the gate and mux patches have a similar issue.

Yea they had and I fixed those. v12 coming out right after this email.

-Tero
