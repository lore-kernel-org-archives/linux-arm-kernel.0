From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 10:35:09 +0000
Subject: [PATCH 0/6] ARM platform spring cleaning
In-Reply-To: <20130315060824.GA9782@lunn.ch>
References: <20130315060824.GA9782@lunn.ch>
Message-ID: <201303151035.09964.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013, Andrew Lunn wrote:
> I see you plan to remove fa526 support.
> 
> Did you see:
> 
> https://lkml.org/lkml/2013/3/13/288

No I had missed that.

> a couple of days ago. Its quite a way from being ready for mainline,
> but assuming Jonas keeps working on this port, he will need fa526
> support.

Ok, I'll drop the fa526 removal patch then. Thanks for pointing me
to that submission.

There was some talk about merging some other fa526 based platform
a while ago, but the people working on that seem to have lost
interest for now, so I assumed that gemini would be the last one.

	Arnd
