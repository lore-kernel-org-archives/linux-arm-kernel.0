From: simon.budig@kernelconcepts.de (Simon Budig)
Date: Fri, 22 Jul 2011 14:47:43 +0200
Subject: Patch: Fix for wrong logic in tx_empty for serial/amba-pl011.c
Message-ID: <4E29716F.2090003@kernelconcepts.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all.

There is a problem with the logic of tx_empty in the amba-pl011 serial
port driver. Instead of checking for an empty FIFO it checks for a
not-full FIFO.

Attached is a patch that fixes this.

Bye,
        Simon Budig

- -- 
       Simon Budig                        kernel concepts GbR
       simon.budig at kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4pcW8ACgkQO2O/RXesiHDwWACeO4HQ2BfdZj/8pEakHQ/njVjs
XuUAoKuyQeBaSJeX3oWp+3OWE4A0+0V3
=nOMx
-----END PGP SIGNATURE-----
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: amba-serial-fix.mbox
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110722/431dabb9/attachment-0001.ksh>
