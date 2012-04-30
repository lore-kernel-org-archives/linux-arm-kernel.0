From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Mon, 30 Apr 2012 14:43:48 +0000
Subject: announcing the clk-next branch
In-Reply-To: <CAJOA=zPdo8d7YMWDhdyNPkKQB_Ae_NiKPhEKxX2JYz=bpXXavQ@mail.gmail.com>
References: <CAJOA=zOGSh3et4nxE=JdojL4uDjgt8o+oiOU4pmbM=oU2U6prA@mail.gmail.com>
 <20120427070925.GO2234@S2101-09.ap.freescale.net>
 <CAJOA=zPdo8d7YMWDhdyNPkKQB_Ae_NiKPhEKxX2JYz=bpXXavQ@mail.gmail.com>
Message-ID: <201204301443.48713.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 April 2012, Turquette, Mike wrote:
> Are you guys OK with this?  I'm OK with you pulling clk-next as a
> dependency if it reduces merge confusion.
> 
> Would I be allowed to rebase clk-next, or must it be stable?  If I
> cannot rebase it then I need a bit of time to remove the conflicting
> clkdev patches that Russell mentioned are already merged through him.

Anything you pull in as a dependency or that gets pulled from your
tree into another one must not be rebased. It helps to ask the person
whose tree you're pulling whether that tree is already considered stable.

	Arnd
