From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 19 Aug 2010 14:47:19 +1000
Subject: [PATCHv2 2/1] Consolidate CONFIG_DEBUG_STRICT_USER_COPY_CHECKS
In-Reply-To: <1282184898-30599-1-git-send-email-sboyd@codeaurora.org>
References: <201008181428.45029.arnd@arndb.de>
	<1282184898-30599-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20100819144719.e690c674.sfr@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Aug 2010 19:28:18 -0700 Stephen Boyd <sboyd@codeaurora.org> wrote:
>
> +config ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
> +	def_bool y

Why not just have

config ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
	bool

in lib/Kconfig.debug

and select that in each arch that want it?

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100819/56db0070/attachment.sig>
