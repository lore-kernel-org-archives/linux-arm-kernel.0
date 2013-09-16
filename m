From: marex@denx.de (Marek Vasut)
Date: Tue, 17 Sep 2013 01:00:09 +0200
Subject: [PATCH v3] PWM: PXA: add device tree support to PWM driver
In-Reply-To: <52375FDB.8090405@wwwdotorg.org>
References: <1379091281-23662-1-git-send-email-mikedunn@newsguy.com>
 <201309161710.15800.marex@denx.de> <52375FDB.8090405@wwwdotorg.org>
Message-ID: <201309170100.09282.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Stephen Warren,

> On 09/16/2013 09:10 AM, Marek Vasut wrote:
> ...
> 
> > OK, to push it ad-absurdum, shall we not start listing every single
> > revision of the CPU as well? Like pxa250a0 250a1 etc ? Yes , this
> > many-to-one mapping is
> 
> It's not about CPU revisions, it's about revisions of the SoC that
> contain the IP block.

But that doesn't matter if the IP block is the same in all of them.

> > something I don't quite understand, that's why I'd love to see a good
> > reasoning from Stephen.
> 
> Please see the earlier discussions.

I did, so I must really be slow or something.

Best regards,
Marek Vasut
