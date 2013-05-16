From: dt.tangr@gmail.com (Daniel Tang)
Date: Thu, 16 May 2013 18:31:38 +1000
Subject: [RFC PATCHv3 3/6] clk: Add TI-Nspire clock drivers
In-Reply-To: <201305151607.54442.arnd@arndb.de>
References: <1368332581-94691-1-git-send-email-dt.tangr@gmail.com>
 <1368332581-94691-4-git-send-email-dt.tangr@gmail.com>
 <201305151607.54442.arnd@arndb.de>
Message-ID: <15FD6543-D04A-4953-A56A-40B27F0026E4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 16/05/2013, at 12:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> You are missing a binding in Documentation/devicetree, same as for some of
> the other drivers in this series.

Should we be adding a vendor prefix to it too? If so, we're not sure whether to use "ti," or not since this isn't an official port by TI.

> It seems strange to assign the clk_name variable to node->name
> first and then overriding it with the clock-output-names property.
> Is that intentional? If so, please explain it in a comment.
> 

I copied that bit of boilerplate from drivers/clk/clk-fixed-rate.c but I'm guessing it's to use the node name as the clock name unless there is a property called "clock-output-names"

Cheers,
Daniel Tang
