From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Feb 2015 21:53:36 +0100
Subject: [PATCH 1/2] phy: usbphy: Add dt documentation for Broadcom Cygnus
 USB PHY driver
In-Reply-To: <54E39DF1.50409@broadcom.com>
References: <1424200821-16368-1-git-send-email-arun.ramamurthy@broadcom.com>
 <8242260.cl4QTECoeX@wuerfel> <54E39DF1.50409@broadcom.com>
Message-ID: <2797126.uqvyZJisPk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 February 2015 12:00:49 Arun Ramamurthy wrote:
> Arnd, I patched the ehci and ohci driver to accept multiple phys so they 
> require different names and cannot both be "usb". That patch was 
> accepted by Alen Stern but I did not update the bindings documentation.
> I will send out another patch for that. Could we go with the naming 
> scheme of "usb" + "p" + port number or do you have other suggestions?

I don't have a good idea, but I think it would be best if the first
phy could remain named "usb" for compatibility with the existing binding.

What is the reason for having two phys in your case? Are these
identical phy devices connected to a single controller or do they
server different purposes?

	Arnd
