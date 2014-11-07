From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 7 Nov 2014 20:44:35 +0100 (CET)
Subject: [PATCH RFC V3 2/3] mxs: add driver for ocotp in i.MX23 and i.MX28
In-Reply-To: <545D1A0D.9050307@vanguardiasur.com.ar>
References: <1413628372-2809-1-git-send-email-stefan.wahren@i2se.com>
 <3434817.dk7dLDFrcN@wuerfel> <544FCFB3.10100@vanguardiasur.com.ar>
 <2223659.OW08fe0cS1@wuerfel>
 <1003885907.22061.1415301932743.JavaMail.open-xchange@oxbsltgw00.schlund.de>
 <545D1A0D.9050307@vanguardiasur.com.ar>
Message-ID: <1818938629.87757.1415389475195.JavaMail.open-xchange@oxbsltgw03.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> hat am 7. November 2014 um
> 20:14 geschrieben:
>
>
> While you are here, maybe you can check if your API and driver will also
> be useful to support i.MX6 OCOTP?

That's why i named the driver fsl_ocotp and not mxs_ocotp ;-)

Sure the handling would be a little different.

>
> I understand that I might be asking too much, and that perhaps i.MX23/28
> eFuses are completely different from other another i.MX.

I don't believe that, but i didn't doublecheck it.

BR Stefan

>
> --
> Ezequiel Garcia, VanguardiaSur
> www.vanguardiasur.com.ar
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
