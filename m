From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 May 2013 16:16:57 +0200
Subject: [RFC PATCHv4 0/6] arm: Initial TI-Nspire support
In-Reply-To: <1369738481.3148.9.camel@hornet>
References: <1369480087-24786-1-git-send-email-dt.tangr@gmail.com>
 <201305262323.29519.arnd@arndb.de>
 <30BA4666-664F-4DA4-A1D5-C2B8AA63C6AB@gmail.com>
 <201305271232.03644.arnd@arndb.de> <1369738481.3148.9.camel@hornet>
Message-ID: <CACRpkdaQfaPQdJ1SDN--JDqcrXs8p6=FaDN+4KtKZF6nLtOvvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 12:54 PM, Pawel Moll <pawel.moll@arm.com> wrote:
> On Mon, 2013-05-27 at 11:32 +0100, Arnd Bergmann wrote:
>> b) add a new KMS driver for this hardware that can be used as an
>> alternative to the existing one and that works with DT.
>
> There are people working on this, just trying to jump through some legal
> hoops to post a RFC. Once this is done we'll be in an interesting
> position of two amba_bus drivers "competing" for the same amba_bus
> device, which I'm not sure how to deal with right now...

Make them mutually exclusive in Kconfig?

Yours,
Linus Walleij
