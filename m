From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 11 Dec 2012 13:52:00 +0000
Subject: linker problem with xip kernel and recent toolchains
In-Reply-To: <50C7386E.70305@pengutronix.de>
References: <50BE0CDB.5000704@pengutronix.de>
 <1355230894.19818.1.camel@hornet> <50C7386E.70305@pengutronix.de>
Message-ID: <1355233920.19818.12.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-12-11 at 13:43 +0000, Marc Kleine-Budde wrote:
> What about putting the notes section into the read only segment, i.e.
> the ROM?

Yes, this is probably a good idea. I'll see to it, thanks!

Pawe?
