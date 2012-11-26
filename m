From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 26 Nov 2012 11:13:25 +0100
Subject: linux-next: manual merge of the arm-soc tree with the sound-asoc
 and pincrtl trees
In-Reply-To: <20121126205312.46fb3f816e1e95ba8cbb5049@canb.auug.org.au>
References: <20121126205312.46fb3f816e1e95ba8cbb5049@canb.auug.org.au>
Message-ID: <50B340C5.1060308@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/26/2012 10:53 AM, Stephen Rothwell :
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in 
> arch/arm/boot/dts/at91sam9263.dtsi between various commits from
> the arm-soc and pinctrl trees and commit 7492e7ca0f95 ("ARM:
> at91/dts: add at91sam9_wdt driver to at91sam926x, at91sam9g45")
> from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no
> action is required).

Good fix. Thanks.

Best regards,
- -- 
Nicolas Ferre
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQEcBAEBAgAGBQJQs0DFAAoJEAf03oE53VmQ6QwIAJFOQ58HXL8RTJMii7T8Qvmj
hP0BVyICTYIJNymKiYk9R2RHXUhz3iwjSGCNYKtnaqcY3G3DQGy2uwwqyGjqTMzB
n0W8s1z3rMr1facVzwlbsVHg/Y+K4a8dJPiwvskUVbRPctKkWYvjdQ+Ruv6v+F9u
a2qqMM8zRNTgZhJvDT3mT4hjLnwRIH3CRckvHKQlDwoxE+Kbhvn3wM2uc9P/bCCX
oVtx05SrCU129RRpztPkvyFzDnuoduznaB9CauSzmKpgzT0PF1yZkDNXgJUCoUXr
jpSRLQg167/yk/2Sufz7pbSB9v10FEO54SavkdbIg00ktKTqc4CIdpKE5Wy1Jws=
=S3HZ
-----END PGP SIGNATURE-----
