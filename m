From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 13 Nov 2012 09:47:46 +0100
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
In-Reply-To: <20121113150631.e316da9049b2ce6685aa729e@canb.auug.org.au>
References: <20121113150631.e316da9049b2ce6685aa729e@canb.auug.org.au>
Message-ID: <50A20932.5000409@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/13/2012 05:06 AM, Stephen Rothwell :
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/configs/afeb9260_defconfig between commit 77614e025061 ("arch:
> Change defconfigs to point to g_mass_storage") from the usb tree and
> commit 2484575268e2 ("arm: at91: drop machine defconfig") from the
> arm-soc tree.
> 
> The latter deletes the file, so I did that and can carry the fix as
> necessary (no action is required).

Absolutely, thanks Stephen.
- -- 
Nicolas Ferre
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQEcBAEBAgAGBQJQogkxAAoJEAf03oE53VmQtxgH/1YpP1OvRv2A8kMAK5zanKHO
J/AanooWZIFrnceRCC5SddeCV667wPoiLiucOuAFQpz5CC0XgSUNRWLEfOQ+x859
y0FXw/Nrbl1OvvFScH4Nm9JeXtoMRpX6t2opTZTjZXy+QeGL6GlNUZx1MvBFOWE7
EbIlWNuf/zNmmxAg5+Wd9du0KIm0xYo5zLYG1isHYA3pEpWVq5bf99V+ym6xg9sL
xFQRxqxyYSJMEhbszIrMszp38ZzE3oDCqWQAFABzQpiTab8+7ykJlP7Rq5RXTfL+
mvd1AtyJjMTbp5Szpa06EDOpNTPaiAuzHEAfwTCHGzxxeo2M4hiOy7nXej1qhCo=
=RVPo
-----END PGP SIGNATURE-----
