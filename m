From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Oct 2018 22:11:09 +0100
Subject: next-20181008 build: 2 failures 22 warnings (next-20181008)
In-Reply-To: <E1g9cV0-0008Sg-4U@optimist>
References: <E1g9cV0-0008Sg-4U@optimist>
Message-ID: <20181008211109.GA4440@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 09:51:30PM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an arm64 defconfig due to:

> 	arm64-defconfig
> ../drivers/acpi/numa.c:34:23: fatal error: asm/kaslr.h: No such file or directory

caused by 3a387c6d96e69 (x86/kaslr, ACPI/NUMA: Fix KASLR build error)
which adds the inclusion unconditionally.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181008/f0000753/attachment.sig>
