From: arend@broadcom.com (Arend van Spriel)
Date: Mon, 25 Nov 2013 18:50:38 +0100
Subject: OMAP build failure after this merge window - caused by usb
 or phy Kconfig krap
In-Reply-To: <20131125140927.GP16735@n2100.arm.linux.org.uk>
References: <20131125140927.GP16735@n2100.arm.linux.org.uk>
Message-ID: <52938DEE.4030905@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2013 03:09 PM, Russell King - ARM Linux wrote:
> which just illustrates why "select" in Kconfig is soo fscking bad that
> it shouldn't be used.

The problem is that instinctively people assume that select is the 
opposite from depends. Unfortunately, it is not and it is a pitfall for 
many.

Gr. AvS
