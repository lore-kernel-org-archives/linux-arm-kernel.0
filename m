From: mikpe@it.uu.se (Mikael Pettersson)
Date: Mon, 28 Sep 2009 12:30:30 +0200
Subject: [PATCH 2/2] n2100: reduce power button timer to 1 Hz
In-Reply-To: <4AC06E8C.8090908@nokia.com>
References: <19134.29011.460366.960746@pilspetsen.it.uu.se>
	<4AC06E8C.8090908@nokia.com>
Message-ID: <19136.36934.791249.535941@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aaro Koskinen writes:
 > Hello,
 > 
 > Mikael Pettersson wrote:
 > > 10 Hz seems excessive, so this patch adds a compile-time option
 > > to reduce the polling frequency to 1 Hz.
 > > 
 > > (This change could possibly be handled via a kernel boot option,
 > > or even be made unconditional, but I opted for a compile-time
 > > option for now.)
 > 
 > I don't think there is need to have an option for this. With HZ also
 > round_jiffies() could be used, it doesn't need to be exact.

I don't quite follow you here. Can you elaborate?
