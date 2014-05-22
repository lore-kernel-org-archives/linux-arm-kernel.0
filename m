From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 22 May 2014 17:10:14 +1000
Subject: linux-next: manual merge of the dt-rh tree with the arm-soc tree
Message-ID: <20140522171014.57e04e48@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Today's linux-next merge of the dt-rh tree got a conflict in
arch/arm/mach-vexpress/platsmp.c between commit d2606f81d563 ("ARM:
vexpress: Simplify SMP operations for DT-powered system") from the
arm-soc tree and commit 9d0c4dfedd96 ("of/fdt: update
of_get_flat_dt_prop in prep for libfdt") from the dt-rh tree.

I fixed it up (the former removed the code modified by the latter) and
can carry the fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140522/7b498ba7/attachment.sig>
