From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Feb 2012 08:50:10 +0000
Subject: [PATCH] ARM: boot/compressed/decompress.c cleanup
In-Reply-To: <1329370449-12033-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1329370449-12033-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <20120216085010.GI13673@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 06:34:09AM +0100, Michael Opdenacker wrote:
> - Remove the ARCH_HAS_DECOMP_WDOG define
>   because it is only used in lib/deflate.c, which
>   only the alpha architecture uses. No other architecture
>   uses this define

No.  Your grepping is broken.
