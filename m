From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Dec 2016 11:20:43 +0000
Subject: next-20161205 build: 3 failures 4 warnings (next-20161205)
In-Reply-To: <E1cDo86-0008IX-9W@optimist>
References: <E1cDo86-0008IX-9W@optimist>
Message-ID: <20161205112043.pyzcbhtu7bklioas@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 07:56:06AM +0000, Build bot for Mark Brown wrote:

Today's -next fails to build an arm64 allnodconfig and allmodconfig
with:

> 	arm64-allnoconfig
> ../arch/arm64/lib/clear_user.S:33: Error: bad or irreducible absolute expression
> ../arch/arm64/lib/clear_user.S:53: Error: bad or irreducible absolute expression
> ../arch/arm64/lib/clear_user.S:33: Error: attempt to move .org backwards
> ../arch/arm64/lib/clear_user.S:53: Error: attempt to move .org backwards
> ../arch/arm64/lib/copy_from_user.S:67: Error: bad or irreducible absolute expression
> ../arch/arm64/lib/copy_from_user.S:70: Error: bad or irreducible absolute expression
> ../arch/arm64/lib/copy_from_user.S:67: Error: attempt to move .org backwards
> ../arch/arm64/lib/copy_from_user.S:70: Error: attempt to move .org backwards
> ../arch/arm64/lib/copy_in_user.S:68: Error: bad or irreducible absolute expression
> ../arch/arm64/lib/copy_in_user.S:71: Error: bad or irreducible absolute expression
> ../arch/arm64/lib/copy_in_user.S:68: Error: attempt to move .org backwards
> ../arch/arm64/lib/copy_in_user.S:71: Error: attempt to move .org backwards
> ../arch/arm64/lib/copy_to_user.S:66: Error: bad or irreducible absolute expression
> ../arch/arm64/lib/copy_to_user.S:69: Error: bad or irreducible absolute expression
> ../arch/arm64/lib/copy_to_user.S:66: Error: attempt to move .org backwards
> ../arch/arm64/lib/copy_to_user.S:69: Error: attempt to move .org backwards

This was triggered somehow by bca8f17f57bd7 (arm64: Get rid of
asm/opcodes.h) though I didn't figure out how.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161205/cd10bb7a/attachment-0001.sig>
