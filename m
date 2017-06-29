From: davem@davemloft.net (David Miller)
Date: Thu, 29 Jun 2017 16:05:13 -0400 (EDT)
Subject: [PATCH 1/6] net: stmmac: support future possible different
 internal phy mode
In-Reply-To: <20170629170238.GA2606@Red>
References: <20170627092806.28181-1-clabbe.montjoie@gmail.com>
 <20170629.122349.2265868886957558079.davem@davemloft.net>
 <20170629170238.GA2606@Red>
Message-ID: <20170629.160513.1064622973584891732.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Thu, 29 Jun 2017 19:02:38 +0200

> On Thu, Jun 29, 2017 at 12:23:49PM -0400, David Miller wrote:
>> From: Corentin Labbe <clabbe.montjoie@gmail.com>
>> Date: Tue, 27 Jun 2017 11:28:01 +0200
>> 
>> > The current way to find if the phy is internal is to compare DT phy-mode
>> > and emac_variant/internal_phy.
>> > But it will negate a possible future SoC where an external PHY use the
>> > same phy mode than the internal one.
>> > 
>> > By using phy-mode = "internal" we permit to have an external PHY with
>> > the same mode than the internal one.
>> > 
>> > Reported-by: Andr? Przywara <andre.przywara@arm.com>
>> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
>> 
>> Series applied.
>> 
>> Please provide a proper "[PATCH 0/n] " header posting next time.
> 
> Sorry could you wait for applying, there are a parallel thread (http://www.spinics.net/lists/devicetree/msg183520.html) and it seems finaly that internal could not be the good way to do it.
> 
> Regards
> Sorry again, I should have sent a comment for waiting.

Please send me a revert patch, when I say I've applied it I already pushed
it out to my GIT tree.
