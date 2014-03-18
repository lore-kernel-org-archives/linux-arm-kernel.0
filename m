From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 18 Mar 2014 10:36:43 +0100
Subject: [PATCH v2] CNS3xxx: Fix PCIe early iotable_init().
In-Reply-To: <201403171537.19546.arnd@arndb.de> (Arnd Bergmann's message of
 "Mon, 17 Mar 2014 15:37:19 +0100")
References: <m3eh2nqz7n.fsf@t19.piap.pl> <m3r46io1nd.fsf@t19.piap.pl>
 <m3eh2inxef.fsf@t19.piap.pl> <201403171537.19546.arnd@arndb.de>
Message-ID: <m3a9cnkfv8.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> Applied to next/fixes-non-critical.
>
> Since the problem is not new and you didn't mark the patch as 'stable',
> this seems to be the right place. Let us know if you need backports
> to stable kernels, also fo the other patch.

Sure, BTW there is also that problem with PCI bridge configuration or
something (maybe on certain boards only) which I can't fix at the
moment, but will do eventually. So absolutely no rush with this/these
patch(es) alone. I just want to make CNS3xxx some valid platform (the
same with IXP4xx and I also have some i.MX6 stuff) but it has to wait
for now.

Thanks,
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
