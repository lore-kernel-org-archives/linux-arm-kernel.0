From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 8 Jul 2013 14:19:21 +0200
Subject: pali's n900 tree: fix compilation
In-Reply-To: <20130708120443.GA2158@amd.pavel.ucw.cz>
References: <20130708120443.GA2158@amd.pavel.ucw.cz>
Message-ID: <201307081419.21572@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 July 2013 14:04:43 Pavel Machek wrote:
> Hi!
> 
> This fixes compilation w/o CONFIG_TWL4030_MADC.
> 
> Please apply :-).
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/arch/arm/mach-omap2/board-rx51-compat.c
> b/arch/arm/mach-omap2/board-rx51-compat.c index
> ceabe8b..f3a82a3 100644

Commited to branch v3.10-n900:
https://gitorious.org/linux-n900/linux-n900/commit/d5da1f5357345ad270a491ce285c78dcf901a7ff

File board-rx51-compat.c contains only maemo5 specified userspace
interfaces. Nothing which can go to upstream. Once if all these interfaces
are removed from maemo5 (CSSU), I will remove them also from my git tree.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130708/f0c8a6f8/attachment.sig>
