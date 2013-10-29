From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 29 Oct 2013 13:08:23 +0100
Subject: linux-next: manual merge of the arm-soc tree with the pm tree
In-Reply-To: <20131029190021.bb2dddcbd46e1ddfdfd5e441@canb.auug.org.au>
References: <20131029190021.bb2dddcbd46e1ddfdfd5e441@canb.auug.org.au>
Message-ID: <1919820.jZeQGKJQBQ@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, October 29, 2013 07:00:21 PM Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-omap2/opp.c between commit e4db1c7439b3 ("PM / OPP: rename
> header to linux/pm_opp.h") from the pm tree and commit 92d51856d740
> ("ARM: OMAP3+: do not register non-dt OPP tables for device tree boot")
> from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

The fix looks good to me, thanks for fixing this up.

Rafael
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131029/87817414/attachment.sig>
