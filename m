From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 26 Nov 2012 11:14:25 +0100
Subject: linux-next: manual merge of the arm-soc tree with the arm-soc
 and pincrtl trees
In-Reply-To: <20121126205615.cda9cfaa998ce6972937d4aa@canb.auug.org.au>
References: <20121126205615.cda9cfaa998ce6972937d4aa@canb.auug.org.au>
Message-ID: <50B34101.5020405@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/26/2012 10:56 AM, Stephen Rothwell :
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in 
> arch/arm/boot/dts/at91sam9g45.dtsi between various commits from
> the arm-soc and pincrtl trees and commit 7492e7ca0f95 ("ARM:
> at91/dts: add at91sam9_wdt driver to at91sam926x, at91sam9g45")
> from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no
> action is required).

Good fix. Thanks for your help Stephen.

Best regards,
- -- 
Nicolas Ferre
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQEcBAEBAgAGBQJQs0EBAAoJEAf03oE53VmQW6kIAK4g8nWh1FloA74ZcfRTIgWQ
/T4jQkub7phq9Q61jZ6yf4SsISpU7UE2q6G71J8Y/JWnYQf+7N8ricr/+B7arVMD
U9xnPnkwEghOIZ6uI7r5rYGypuIdUwAJSb9pg8h7O+ISi7vgEUxiiZRioyb8qBH9
NBFTQr9mLiu89fi9iN5N2QMJdn7L3qE+K6JRbRjXbxv9O2kFCWqEBGxyWNtBzAe3
rLSnRTtI2Oh5UZ0bTi5khL+hcJLsw/rcNv/6odhc1A/bDlZKVoMKlR0sZI9DQx4w
pOtlhxsWX8c4XiTXVKn5fk9wjAOhXSJTfZbNo8Ii2ndGuWorNYoYF2Cm9NuiUSI=
=nzDW
-----END PGP SIGNATURE-----
