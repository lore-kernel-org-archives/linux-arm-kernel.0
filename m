From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 13 Nov 2012 09:51:33 +0100
Subject: linux-next: manual merge of the arm-soc tree with the pinctrl tree
In-Reply-To: <20121113151754.98aa6471baaf062826c3b133@canb.auug.org.au>
References: <20121113151754.98aa6471baaf062826c3b133@canb.auug.org.au>
Message-ID: <50A20A15.6090506@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/13/2012 05:17 AM, Stephen Rothwell :
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in 
> drivers/tty/serial/atmel_serial.c between commit 784557decc48
> ("tty: atmel_serial: add pinctrl support") from the pinctrl tree
> and commit bcd2360c1ff9 ("arm: at91: move platfarm_data to 
> include/linux/platform_data/atmel.h") from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no
> action is required).

Stephen, it is the proper merge.

Thanks a lot.

Best regards,
- -- 
Nicolas Ferre
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQEcBAEBAgAGBQJQogoUAAoJEAf03oE53VmQAt0H/iThKsKe+ag10z9Q8xlO6sqR
dvfFtRQxv7W1xVeRc/RJjnE/thKaa+FMiUfvFoj4Gls6UZD3vAvwatI+kkGY30yp
FbflguygU8OvAQcr/dpVx2tBzsqCk7Xynk+D0+DjlJXukP+JzP+3/tl7Gd0/lct7
nLccb1X0sNwTrvlLJO2WJuOGwFlTU3vO1wkehgic2ozfm3FzsaTLUjkUf6YXOG1N
BoABfHJL0PyNk6iENu26j6ulDPaWrpJe5531hTcJm16X+h2gnmnnjpYw9dTTQ5qO
La0UeqkqTxEUOFmo3cxbS0ryBeQBTmHss61JLVcqnlwApTscefmD4x8G310D7oA=
=mEy6
-----END PGP SIGNATURE-----
