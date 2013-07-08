From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 8 Jul 2013 14:03:04 +1000
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20130708140304.39c17c16e878a8eb26eaf5a1@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap2/Kconfig between commit 4a1b573346ee ("ARM: 7758/1:
introduce config HAS_BANDGAP") from Linus' tree and commit 59d92875a6d9
("ARM: OMAP: build mach-omap code only if needed") from the arm-soc tree.

I fixed it up (the latter moved the "config ARCH_OMAP2PLUS" and included
the "select ARCH_HAS_BANDGAP" despite there being no ARCH_HAS_BANDGAP
config in the arm-soc tree :-() and can carry the fix as necessary (no
action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130708/a745db71/attachment.sig>
