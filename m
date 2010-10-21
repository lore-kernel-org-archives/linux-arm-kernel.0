From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Oct 2010 14:02:40 +0200
Subject: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
In-Reply-To: <AANLkTimWG_38hY2Xq=G7r42eP+zmA24Gaw4-hLVJstVA@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<201010211104.28555.arnd@arndb.de>
	<AANLkTimWG_38hY2Xq=G7r42eP+zmA24Gaw4-hLVJstVA@mail.gmail.com>
Message-ID: <201010211402.40272.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 October 2010, Ohad Ben-Cohen wrote:
> The change is also pretty trivial:
> 
> * move the internal locking implementation to raw_ methods
> * the raw_ methods would save the current interrupt state only if
> given a placeholder
> * wrap those raw_ methods with the desired API (but only support the
> _irq and _irqsave flavors)
> 

Sounds good!

	Arnd
