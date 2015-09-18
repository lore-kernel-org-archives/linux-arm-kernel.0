From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Sep 2015 23:28:28 +0200
Subject: [PATCH v2 3/9] ARM: dts: Remove unused PCI I/O resource in Cygnus
In-Reply-To: <1442611454-16331-4-git-send-email-rjui@broadcom.com>
References: <1442611454-16331-1-git-send-email-rjui@broadcom.com>
 <1442611454-16331-4-git-send-email-rjui@broadcom.com>
Message-ID: <4598126.bTshpfCuvX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 September 2015 14:24:08 Ray Jui wrote:
> Remove unused PCI I/O resource in bcm-cygnus.dtsi
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> 

Why? How do you know that nobody ever plugs in a card with I/O ports?

	Arnd
