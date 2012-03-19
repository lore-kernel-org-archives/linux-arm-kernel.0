From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 19 Mar 2012 10:00:27 +0100
Subject: linux-next: manual merge of the arm-soc tree with the l2-mtd tree
In-Reply-To: <20120319174743.aff001d4f84e82cf4042277a@canb.auug.org.au>
References: <20120319174743.aff001d4f84e82cf4042277a@canb.auug.org.au>
Message-ID: <4F66F5AB.7020600@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/19/2012 07:47 AM, Stephen Rothwell :
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in 
> drivers/mtd/nand/atmel_nand.c between commit 4331c79c6895 ("mtd: do
> not use plain 0 as NULL") from the l2-mtd tree and commit
> d6a016616ba8 ("atmel/nand: add DT support") from the arm-soc tree.
> 
> The latter superceded the former, so I used that.

That is definitively the proper fix. Thanks Stephen.

Best regards,
- -- 
Nicolas Ferre
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPZvWlAAoJEAf03oE53VmQd0EIAKV1xC3F+fd6lvu3rKNyzUl0
yfcvNtc9cFbwuR9A3cbeoCo6FbfdSpsT2eT8v+DZ5LDvPmJ9ln9jgqyldq+QfblU
2KpyOWSLeLpG6ILky7Hlo4tjm1NA3GNZGLpyQ2Yln5r17zeTHqaCBeL+xHXOdgcM
Uvrrix67AmnL91nF4QNPdOfKYnv2h+J2OWW6ukFBajQOMBIiVeddVL62qKYOvq0K
QrgTa5D4cygvD0NUMTrrJ5GXjR+afAL7K5pk0Aab9C6pzgKGVredD5qSu/Zpbn8n
+aHXNyfqLQ9+7++a+hm6VNMTrMZxFo/MZoQZsigu7JkJ8lDTNhsaWkm3QqWl4c4=
=6Y0V
-----END PGP SIGNATURE-----
