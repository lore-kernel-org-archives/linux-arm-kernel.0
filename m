From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Apr 2016 10:22:16 +0200
Subject: [PATCH v2 04/11] clocksource/moxart: Generalise timer for use on
 other socs
In-Reply-To: <1461225849-28074-5-git-send-email-joel@jms.id.au>
References: <1461225849-28074-1-git-send-email-joel@jms.id.au>
 <1461225849-28074-5-git-send-email-joel@jms.id.au>
Message-ID: <4840688.ZUmiMtO0cR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2016 17:34:02 Joel Stanley wrote:
> The moxart timer IP is shared with another soc made by Aspeed.
> Generalise the registers that differ so the same driver can be used for
> both.
> 
> As we now depend on CLKSRC_MMIO, create a Kconfig symbol for the driver
> so we can express this dependency.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> 

Any idea where the IP block came from? Moxart contains a lot of
licensed IP from faraday-tech. If this is one of them, we could
maybe rename the driver accordingly.

	Arnd
