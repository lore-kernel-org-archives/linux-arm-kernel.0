From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Fri, 26 Sep 2014 16:27:10 +0200
Subject: [PATCH v3 11/12] mmc: sunxi: Convert MMC driver to the standard
 clock phase API
In-Reply-To: <1410466706-27386-12-git-send-email-maxime.ripard@free-electrons.com>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
 <1410466706-27386-12-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <3992138.y6J8TjIuMq@pagira.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello
> Now that we have proper support to use the generic phase API in our clock
> driver, switch the MMC driver to use it.
> [...]
>  	/* determine delays */
>  	if (rate <= 400000) {
> -		oclk_dly = 0;
> -		sclk_dly = 7;
> +		oclk_dly = 180;
> +		sclk_dly = 42;
> [...]
How did you calculate the actual phase values from the original parameters?

greatings
-- 
David Lanzend?rfer
OpenSourceSupport GmbH
System engineer and supporter
http://www.o2s.ch/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/8bc39436/attachment.sig>
