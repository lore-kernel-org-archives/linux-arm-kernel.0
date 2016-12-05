From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Dec 2016 10:44:55 +0000
Subject: next-20161205 build: 3 failures 4 warnings (next-20161205)
In-Reply-To: <E1cDo86-0008IX-9W@optimist>
References: <E1cDo86-0008IX-9W@optimist>
Message-ID: <20161205104455.2m5ky3hgd5n2kb2w@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 07:56:06AM +0000, Build bot for Mark Brown wrote:

Today's -next fails to build an arm64 allmodconfig:  

> 	arm64-allmodconfig
> ../arch/arm64/include/asm/probes.h:18:25: fatal error: asm/opcodes.h: No such file or directory

due to bca8f17f57bd76d (arm64: Get rid of asm/opcodes.h) having missed
one reference to the header.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161205/8b5dd2e2/attachment-0001.sig>
