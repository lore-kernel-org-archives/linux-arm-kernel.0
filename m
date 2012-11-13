From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 13 Nov 2012 09:48:29 +0100
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
In-Reply-To: <20121113152029.9bcfc18a4bca8dc53a033a86@canb.auug.org.au>
References: <20121113152029.9bcfc18a4bca8dc53a033a86@canb.auug.org.au>
Message-ID: <50A2095D.3020306@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/13/2012 05:20 AM, Stephen Rothwell :
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/configs/stamp9g20_defconfig between commit 77614e025061
> ("arch: Change defconfigs to point to g_mass_storage") from the usb
> tree and commit 2484575268e2 ("arm: at91: drop machine defconfig")
> from the arm-soc tree.
> 
> The latter deleted the file so I did that and can carry the fix as 
> necessary (no action is required).

Yes. Thanks a lot Stephen.

Best regards,
- -- 
Nicolas Ferre
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQEcBAEBAgAGBQJQogldAAoJEAf03oE53VmQqTgIAKUtqhwnXt8Rm1x+ERPiPLno
VhFc1ZPgiPUepSecHMFPCcWtgwLBg6HUFXg4muM7kpf1hvMtAB6CmpasjceV8g0N
KMFC4GrRi6y0dp59DpBUa1gB87i4gpliqmroO3YGu8iGDHGowDBV8HsfmNpLmGTJ
WmdjDzpWE3hfLjNl5F0qnkI1cqDAyWrQwE9cNIFpzY93GfKkVTjdxiKIf6PprJl8
SIicUbeHV/lrNyusEZw0CcNa89qtKCovdBN7Yk64xwyyTnLprxq/Sr30WaFx4npf
A6vdUeCsKL3glD67rD7MUYXZ5KS0pLOuxIVJvvlugbOCwrNDPrZd6NZhqFkgMh8=
=Fpq2
-----END PGP SIGNATURE-----
