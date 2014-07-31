From: davem@davemloft.net (David Miller)
Date: Thu, 31 Jul 2014 11:59:11 -0700 (PDT)
Subject: [PATCH net v3 0/6] net: stmmac: Improve mcast/ucast filter for
 snps
In-Reply-To: <1406671607-27368-1-git-send-email-vbridgers2013@gmail.com>
References: <1406671607-27368-1-git-send-email-vbridgers2013@gmail.com>
Message-ID: <20140731.115911.404121838921688216.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vince Bridgers <vbridgers2013@gmail.com>
Date: Tue, 29 Jul 2014 17:06:41 -0500

> This patch series adds Synopsys specific bindings for the Synopsys EMAC
> filter characteristics since those are implementation dependent. The
> multicast and unicast filtering code was improved to handle different
> configuration variations based on device tree settings. 
> 
> I verified the operation of the multicast and unicast filters through 
> Synopsys support as requested during the V1 review, and tested the GMAC
> configuration on an Altera Cyclone 5 SOC (which supports 256 multicast
> bins and 128 Unicast addresses). The 10/100 variant of this driver
> modification was not tested, although it was compile tested. I shared
> the email thread results of the investigation through Synopsys with the
> stmmac maintainer.

Please update this series taking into account the feedback you've
received for patch #6, thanks.
