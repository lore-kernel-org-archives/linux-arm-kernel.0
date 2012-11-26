From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 26 Nov 2012 11:39:42 +0100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
In-Reply-To: <20121126213152.60b52e19d7fc84ce94c356c3@canb.auug.org.au>
References: <20121126213152.60b52e19d7fc84ce94c356c3@canb.auug.org.au>
Message-ID: <50B346EE.1050306@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/26/2012 11:31 AM, Stephen Rothwell :
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in 
> drivers/tty/serial/atmel_serial.c between commit 95e629b761ce 
> ("ARM/AVR32: get rid of serial_at91.h") from the arm tree and
> commit bcd2360c1ff9 ("arm: at91: move platfarm_data to 
> include/linux/platform_data/atmel.h") from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no
> action is required).

Yes, good fix that has to be carried...

Thanks, bye,
- -- 
Nicolas Ferre
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQEcBAEBAgAGBQJQs0buAAoJEAf03oE53VmQMPgH/0Gynlb5BBImnjSU75mh/dPC
ob/lTJv3w/2gUKPqbOgyxTSmMc9ckFcDELAhFYt+df9hKfOMBzZAUPHLEclZolZ+
AqpnIjGq88TYWMgaREUZ2bigTrzuWKqHiIWV/AoNcz2slhWC//CHK6z9SHE7hZOI
zZFwf326v0dRkm4g785cqalg7pNxQDpE6iMZXuifb8zPWePgKBxqHyPRCbhP1dwu
T4XQ3IgnrvzWcqz/V4mr8kppJXzHNfDEsVZ2XfndhUKVFY4qMGZhFBoTlI6LhNWO
Nu2mD7TaENoKRijLYrdMfidJ65uwAGtEWA6UxEfV1VWVddSsi/D8OuniBta+Ewg=
=zF93
-----END PGP SIGNATURE-----
