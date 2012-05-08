From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 8 May 2012 15:29:27 +0100
Subject: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
In-Reply-To: <201205081348.14269.arnd@arndb.de>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <20120508121940.GL15893@opensource.wolfsonmicro.com>
 <4FA913BA.30908@linaro.org> <201205081348.14269.arnd@arndb.de>
Message-ID: <20120508142926.GT15893@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2012 at 01:48:14PM +0000, Arnd Bergmann wrote:
> On Tuesday 08 May 2012, Lee Jones wrote:

> > I did run this past Arnd before writing the code and he agreed that this 
> > would be suitable; however, if you know of a better way in which I can 
> > do this, I'd be pleased to hear of it.

> It was the best approach that I could think of for this, but I'm also
> a total newbie on regulators.

It's not really a regulator thing, what the code is doing is blasting in
a bunch of magic register writes to set things up, some of which are
configuring things that the subsystem already knows how to configure.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120508/e9ec091a/attachment.sig>
