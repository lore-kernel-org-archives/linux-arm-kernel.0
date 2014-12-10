From: davem@davemloft.net (David Miller)
Date: Wed, 10 Dec 2014 12:02:44 -0500 (EST)
Subject: [PATCH v8 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <34612839.hAkXUcbKUQ@wuerfel>
References: <2331317.LV3gPP3odb@wuerfel>
 <20141210.110732.519666115784722516.davem@davemloft.net>
 <34612839.hAkXUcbKUQ@wuerfel>
Message-ID: <20141210.120244.722990295139076460.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 Dec 2014 17:36:46 +0100

> Or is there any better alternative for broken hardware that lacks
> a TX-complete interrupt?

The only option is an hrtimer or similar.
