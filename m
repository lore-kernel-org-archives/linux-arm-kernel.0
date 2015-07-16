From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 16 Jul 2015 13:07:37 +0200 (CEST)
Subject: [PATCH 2/3] nmi: x86: convert to generic nmi handler
In-Reply-To: <E1ZFTSr-0006v7-8G@rmk-PC.arm.linux.org.uk>
References: <20150715203911.GF7557@n2100.arm.linux.org.uk>
 <E1ZFTSr-0006v7-8G@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.11.1507161307170.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Jul 2015, Russell King wrote:

> Convert x86 to use the generic nmi handler code which can be shared
> between architectures.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-and-tested-by: Thomas Gleixner <tglx@linutronix.de>
