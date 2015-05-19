From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 May 2015 20:42:34 +0200
Subject: [PATCH] [RESEND] SCSI: ips: remove pointless #warning
In-Reply-To: <1432060697.14737.1.camel@HansenPartnership.com>
References: <3121960.dnOqT9LCth@wuerfel> <2850783.725LtIIUFq@wuerfel>
 <1432060697.14737.1.camel@HansenPartnership.com>
Message-ID: <17880859.7GjlLRguJk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 May 2015 11:38:17 James Bottomley wrote:
> 
> Actually, no, that would cause problems if anyone is actually using this
> driver on non-intel.  What about this?  It captures the intent of the
> original but gets rid of the warning.
> 
> 

Good idea, thanks!

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
