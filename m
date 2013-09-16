From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Sep 2013 13:45:31 -0600
Subject: [PATCH v3] PWM: PXA: add device tree support to PWM driver
In-Reply-To: <201309161710.15800.marex@denx.de>
References: <1379091281-23662-1-git-send-email-mikedunn@newsguy.com>
 <201309151607.04244.marex@denx.de> <523718D3.4050003@newsguy.com>
 <201309161710.15800.marex@denx.de>
Message-ID: <52375FDB.8090405@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2013 09:10 AM, Marek Vasut wrote:
...
> OK, to push it ad-absurdum, shall we not start listing every single revision of 
> the CPU as well? Like pxa250a0 250a1 etc ? Yes , this many-to-one mapping is 

It's not about CPU revisions, it's about revisions of the SoC that
contain the IP block.

> something I don't quite understand, that's why I'd love to see a good reasoning 
> from Stephen.

Please see the earlier discussions.
