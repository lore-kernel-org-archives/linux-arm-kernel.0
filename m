From: davem@davemloft.net (David Miller)
Date: Fri, 29 Jan 2016 20:34:16 -0800 (PST)
Subject: [PATCH v2 0/7] network driver fixes
In-Reply-To: <1454067557-3546883-1-git-send-email-arnd@arndb.de>
References: <1454067557-3546883-1-git-send-email-arnd@arndb.de>
Message-ID: <20160129.203416.1451706111708529250.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 29 Jan 2016 12:39:08 +0100

> This is an updated series of fixes for the network device drivers
> that showed warnings in ARM randconfig.
> 
> Changes since v1 are:
> 
> dropped "net: macb: avoid uninitialized variables", already fixed in net-next
> 
> dropped "net: fddi/defxx: avoid warning about uninitialized variable
> 	use", already fixed in net-next
> 
> added missing barriers in "net: moxart: use correct accessors for
> 	DMA memory"
> 
> clarified "net: bgmac: clarify CONFIG_BCMA dependency" changelog

Series applied, thanks.
