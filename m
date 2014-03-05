From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 5 Mar 2014 09:32:40 +0200
Subject: [PATCHv2 14/14] ARM: OMAP3: clock: remove legacy clock data
In-Reply-To: <20140304173242.GB17470@atomide.com>
References: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
 <1393924700-6510-15-git-send-email-t-kristo@ti.com>
 <20140304173242.GB17470@atomide.com>
Message-ID: <5316D318.8080405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2014 07:32 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [140304 01:22]:
>> This is no longer needed as clock data is provided through DT.
>
> And this one we cannot apply yet until omap3 is booting in device tree
> only mode.

What is missing to achieve this? Some boards are not booting in DT mode 
yet or?

-Tero
