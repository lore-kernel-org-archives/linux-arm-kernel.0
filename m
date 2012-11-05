From: stigge@antcom.de (Roland Stigge)
Date: Mon, 05 Nov 2012 18:35:54 +0100
Subject: [PATCH] lpc32xx: irq - Set the chain handlers after setting up
 the IRQ domain
In-Reply-To: <20121105180053.20090a3e@avionic-0020.adnet.avionic-design.de>
References: <1351772626-12615-1-git-send-email-alban.bedel@avionic-design.de>
 <50938BFD.1000402@antcom.de>
 <20121105180053.20090a3e@avionic-0020.adnet.avionic-design.de>
Message-ID: <5097F8FA.6040605@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 05/11/12 18:00, Alban Bedel wrote:
>> I already posted basically the same change on 2012-10-28 already which
>> is part of my patch set for LPC32xx to be merged into arm-soc.git (will
>> do a pull request later). Fixing another irq bug in this platform/irq also.
> 
> I checked arm-soc.git, linux-next.git, linux-arm-kernel@ and
> linux-kernel@, is there any other place I should check before
> submitting LPC32xx patches?

I usually prepare lpc32xx branches for merging into arm-soc.git at
git.antcom.de. Expect the posted patches there and a pull request during
the next days.

Thanks,

Roland
