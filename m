From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Thu, 29 Jan 2015 07:37:48 +0100
Subject: [PATCH] ARM: cns3xxx: fix typo in PCI config accessor
In-Reply-To: <2000255.rnmr9HfSOg@wuerfel> (Arnd Bergmann's message of "Wed, 28
 Jan 2015 14:53:07 +0100")
References: <2000255.rnmr9HfSOg@wuerfel>
Message-ID: <m3y4omw0qr.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> The recent patch to convert the cns3xxx PCI code added an
> extraneous opening bracket, which makes the build fail,
> so remove this.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 10e2c5540d48 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
Acked-by: Krzysztof Ha?asa <khalasa@piap.pl>

-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
