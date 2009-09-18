From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Sep 2009 20:57:18 +0100
Subject: [PATCH] SA1100: initialise spinlock in DMA code
In-Reply-To: <1253291437-16452-1-git-send-email-mad_soft@inbox.ru>
References: <1253291437-16452-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <20090918195718.GD6601@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2009 at 08:30:37PM +0400, Dmitry Artamonow wrote:
> Declare it using DEFINE_SPINLOCK()
> 
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>

Ok.  -> patch system please.
