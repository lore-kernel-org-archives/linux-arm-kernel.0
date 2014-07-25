From: afaerber@suse.de (=?ISO-8859-1?Q?Andreas_F=E4rber?=)
Date: Fri, 25 Jul 2014 12:32:43 +0200
Subject: [PATCH v2 09/11] Documentation: devicetree: Fix ADI AXI SPDIF
 specification
In-Reply-To: <20140725101815.GO17528@sirena.org.uk>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-10-git-send-email-afaerber@suse.de>
 <53D20A61.1050506@metafoo.de> <53D21066.8000905@monstr.eu>
 <20140725101815.GO17528@sirena.org.uk>
Message-ID: <53D2324B.4070602@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 25.07.2014 12:18, schrieb Mark Brown:
> On Fri, Jul 25, 2014 at 10:08:06AM +0200, Michal Simek wrote:
> 
>> All these patches have been added through your tree that's why I
>> think you should take this fix through his tree.
> 
> If someone could send me patches I'll take a look at them.

I used scripts/get_maintainer.pl --nogit-fallback. If you were not
CC'ed and need to be, please submit a MAINTAINERS patch. :)

Maybe this works for you?
https://patchwork.kernel.org/patch/4620191/

Otherwise I can resend with Ab/Rb.

Andreas

- -- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJT0jJLAAoJEPou0S0+fgE/od0QAItNVBWohkpacvB5M+Oh0x5H
40aYXWOPVrAHRfXlh5SsSQyba/2P6q719meJL3FseU7Jj+rbkPnICf3q5KWgN3Vb
iXoO+UQPn/gvredRql9g5eUj0xeh6j3bIAmEYmmme3opg0siKV1Gd6D9vEezjL8x
M3xroJ05EbhjAd1UrgW/xEINAfDExLXbUQhsbls1tzL7WL9Cx4Obi7/KWiAVATMU
RPNQiz8zyVXoJq0i596fAKX+EPaID2ztr26IQtpH+vOJOpRhtQeX+B+HBxTm89yO
mg7ZnklhXFFaAYhXKEm1itMbi8OnCUzDuk5hPklCJF+WgzBbyq29erx53VaRQAij
jrebNU4UB0/si7Gnl/XwvRMDUaVDkF6OaeeSjwKZvk0R6o02lperM51gKOgsDdC9
G9VPb9AoNvbebEaNvonU22gB81RWg1MFkW7XF1Enj0C+xINePG86TXpWNiNUPfdV
QAyYhwrAlePV4tKYqnyDd1d8orPs5TySVt3tuloUTB17IpYXM7OWj7db5so5V6O2
99m2rrcMCP5SxDiuB0LUbKxrBoIhGH2kZ0k476Xb/YOYgpBskOxFLqZ+ptzZDW7K
a3frjJ98QKjb5z9fZ1qZBzbegggAEvXlhpIgcaWAkT1wV3vmZhQjycpDHNWuahsu
ybMjvgNj/YiougCN+7bf
=zr8g
-----END PGP SIGNATURE-----
