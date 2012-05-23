From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Wed, 23 May 2012 22:14:44 +0200
Subject: ARM: ETH PHY Micrel: KSZ8051MNL Driver?
In-Reply-To: <1337720919.493.YahooMailClassic@web45209.mail.sp1.yahoo.com>
 (Shmuel Yitzhaki's message of "Tue, 22 May 2012 14:08:39 -0700 (PDT)")
References: <1337720919.493.YahooMailClassic@web45209.mail.sp1.yahoo.com>
Message-ID: <87obpepscr.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Shmuel" == Shmuel Yitzhaki <shmuelyi@yahoo.com> writes:

 Shmuel> Hi Everyone,
 Shmuel> Do you know if this newer chip is compatible with older Micrel devices
 Shmuel> (supported at mainline)?
 Shmuel> Did anyone try using it? results?

I'm using it with the generic genphy driver without any problems. I
haven't tried the micrel driver, but as the board doesn't have the
interrupt connected it wouldn't really buy me anything.

I can give the micrel driver a try if you want though.

-- 
Bye, Peter Korsgaard
