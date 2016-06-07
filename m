From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jun 2016 13:04:12 +0100
Subject: [PATCH] ARM: Keystone: Introduce Kconfig option to compile in
 typical Keystone features
In-Reply-To: <10295246.2MDnqWQbb8@wuerfel>
References: <1464816714-3900-1-git-send-email-nm@ti.com>
 <574F6674.3010100@ti.com> <20160607042853.GA22406@atomide.com>
 <10295246.2MDnqWQbb8@wuerfel>
Message-ID: <20160607120412.GU7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 10:09:46AM +0200, Arnd Bergmann wrote:

Please start new threads for things like this - there's no obvious
relevance to me in either the subject or even the first couple of pages
of the message so it very nearly got deleted unread.  It's very common
to get copied on irrelevant stuff so things with no obvious motivation.

> REGULATOR_FIXED_VOLTAGE is needed by a lot of platforms that usually
> don't select it, so it might be good to add a 'default y' to its Kconfig
> symbol, or we could add 'select REGULATOR_FIXED_VOLTAGE if REGULATOR'
> to all platforms that need it. The driver is about 1.5KB in size, compared
> to about 50KB for the regulator core.

The platforms should do this - I wouldn't say it's *that* common,
especially not as a build time dependency with things moving to DT.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/62ec22b8/attachment.sig>
