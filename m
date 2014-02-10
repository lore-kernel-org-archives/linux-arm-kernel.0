From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Feb 2014 11:41:54 +0000
Subject: [PATCH 14/28] Remove MACH_SMDKC210
In-Reply-To: <1391971686-9517-15-git-send-email-richard@nod.at>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
 <1391971686-9517-15-git-send-email-richard@nod.at>
Message-ID: <20140210114154.GQ1757@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 09, 2014 at 07:47:52PM +0100, Richard Weinberger wrote:

> The symbol is an orphan, get rid of it.

Please fix whatever script you're using to generate your mails, it's
generating corrupt headers.  Please also use subject lines consistent
with the rest of the subsystem - between the two I very nearly just
deleted this unread, it's only Paul's mail that made me look.

>  config SND_SOC_SAMSUNG_SMDK_WM9713
>  	tristate "SoC AC97 Audio support for SMDK with WM9713"
> -	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110 || MACH_SMDKV310 || MACH_SMDKC210)
> +	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110 || MACH_SMDKV310)

Like I said to Paul this isn't fixing the actual issue - think about why
the symbol was there in the first place and why it was removed.  There
is a problem here but this would make it less likely that it would be
properly fixed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140210/45e54c4b/attachment.sig>
