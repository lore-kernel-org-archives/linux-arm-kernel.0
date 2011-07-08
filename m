From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jul 2011 21:38:32 +0100
Subject: [PATCH] ARM: support XZ compressed kernels
In-Reply-To: <1310033999-25617-1-git-send-email-kaloz@openwrt.org>
References: <1310033999-25617-1-git-send-email-kaloz@openwrt.org>
Message-ID: <20110708203832.GV4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 12:19:59PM +0200, Imre Kaloz wrote:
>  # Make sure files are removed during clean
> -extra-y       += piggy.gzip piggy.lzo piggy.lzma lib1funcs.S
> +extra-y       += piggy.gzip piggy.lzo piggy.lzma piggy.xzkern lib1funcs.S ashldi3.S

Is there a reason the suffix is xzkern rather than just xz ?
