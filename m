From: wolfgang.mues@auerswald.de (Wolfgang =?iso-8859-1?q?M=FCes?=)
Date: Thu, 25 Feb 2010 08:58:06 +0100
Subject: Fwd: [PATCH] Bugfixing and improvement of the AT91 MCI driver
In-Reply-To: <cd73a99e1002241059o3cc6c58es8e9910c55d4ac896@mail.gmail.com>
References: <cd73a99e1002241059o3cc6c58es8e9910c55d4ac896@mail.gmail.com>
Message-ID: <201002250858.06449.wolfgang.mues@auerswald.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Am Mittwoch, 24. Februar 2010 schrieb Andrew Victor:
> Thanks for the patch.
> 
> There has been quite a bit of work done recently to update the
> atmel_mci driver to support both the AVR32 and AT91 platforms.
Yes, I have seen the atmel_mci driver in recent kernels.

But I also have seen the massive amount of debug code in this driver, and the 
fact that DMA is marked "experimental", and that DMA is not available for AT91 
(only for AVR32). So my conclusion was that this driver is not ready for 
production use on AT91. (We *need* DMA because we have some CPU-intensive 
tasks).

I think both drivers will be parallel in the kernel for a while - until the 
atmel_mci driver can replace the at91_mci driver fully.

> Nicolas Ferre maintains the at91_mci driver.
Ah, OK. Sorry, my fault.

best regards
 
i. A. Wolfgang M?es
-- 
Auerswald Gesellschaft f?r Datensysteme mbH
Hardware Development
Telefon: +49 (0)5306 9219 562
Telefax: +49 (0)5306 9219 94 
E-Mail: Wolfgang.Mues at Auerswald.de
Web: http://www.auerswald.de
 
--------------------------------------------------------------
Auerswald Gesellschaft f?r Datensysteme mbH
Vor den Grash?fen 1, 38162 Cremlingen
Registriert beim AG Braunschweig HRB 7499
Gesch?ftsf?hrer: Dipl-Ing. Gerhard Auerswald
