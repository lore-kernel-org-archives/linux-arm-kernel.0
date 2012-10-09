From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Oct 2012 17:04:41 +0100
Subject: [PATCH 5/9] ARM: Xen: fix initial build problems:
In-Reply-To: <1349796183-30648-6-git-send-email-arnd@arndb.de>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
 <1349796183-30648-6-git-send-email-arnd@arndb.de>
Message-ID: <20121009160441.GF4625@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 05:22:59PM +0200, Arnd Bergmann wrote:
> * The XEN_BALLOON code requires the balloon infrastructure that is not
>   getting built on ARM.
> 
> * The tmem hypercall is not available on ARM
> 
> * ARMv6 does not support cmpxchg on 16-bit words that are used in the

"in the" what?
