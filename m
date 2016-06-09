From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Jun 2016 11:32:03 +0100
Subject: [PATCH] ARM: Keystone: Introduce Kconfig option to compile in
 typical Keystone features
In-Reply-To: <20160609065035.GJ22406@atomide.com>
References: <1464816714-3900-1-git-send-email-nm@ti.com>
 <10295246.2MDnqWQbb8@wuerfel> <20160608094747.GG22406@atomide.com>
 <8052110.nPS5mbu3uO@wuerfel> <20160609065035.GJ22406@atomide.com>
Message-ID: <20160609103203.GT7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 11:50:35PM -0700, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [160608 09:06]:

> > The downside would be any users that want the options we enable there
> > turned off and have them silently enabled when upgrading the kernel.

> I think the long term solution here might be to generate the .config
> out of dts files..

That would be cool!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/df61448c/attachment.sig>
