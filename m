From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Dec 2016 17:20:55 +0000
Subject: next-20161205 build: 3 failures 4 warnings (next-20161205)
In-Reply-To: <7b3daf13-dbab-5acf-cd5f-2414141500b3@arm.com>
References: <E1cDo86-0008IX-9W@optimist>
 <20161205112043.pyzcbhtu7bklioas@sirena.org.uk>
 <7b3daf13-dbab-5acf-cd5f-2414141500b3@arm.com>
Message-ID: <20161205172055.nfid7v4vu3v7ik3q@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 03:44:30PM +0000, Marc Zyngier wrote:

> Old and broken gas. I have a workaround stashed there:

> http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/commit/?h=arm64/standalone.h&id=559f97365362ed9e96f594200020379df46630d8

> At least binutils 2.24 and 2.25 are affected, while 2.27 is not.

Not that old - this is the Linaro 2015.10 toolchain which wasn't super
new but not exactly from the mists of time either.  Anyway, I updated to
2016.11 (GCC 6.2.1, GAS 2.27)...  let's see what the fallout is like.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161205/1f2213ac/attachment.sig>
