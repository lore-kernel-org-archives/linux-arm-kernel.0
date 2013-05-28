From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 28 May 2013 11:54:41 +0100
Subject: [RFC PATCHv4 0/6] arm: Initial TI-Nspire support
In-Reply-To: <201305271232.03644.arnd@arndb.de>
References: <1369480087-24786-1-git-send-email-dt.tangr@gmail.com>
 <201305262323.29519.arnd@arndb.de>
 <30BA4666-664F-4DA4-A1D5-C2B8AA63C6AB@gmail.com>
 <201305271232.03644.arnd@arndb.de>
Message-ID: <1369738481.3148.9.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-05-27 at 11:32 +0100, Arnd Bergmann wrote:
> b) add a new KMS driver for this hardware that can be used as an
> alternative to the existing one and that works with DT.

There are people working on this, just trying to jump through some legal
hoops to post a RFC. Once this is done we'll be in an interesting
position of two amba_bus drivers "competing" for the same amba_bus
device, which I'm not sure how to deal with right now...

Pawe?
