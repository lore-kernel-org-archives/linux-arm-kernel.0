From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Thu, 24 Nov 2011 07:45:17 +0100
Subject: [PATCH 14/41] ARM: restart: iop3xx: use new restart hook
In-Reply-To: <20111117172858.GA9581@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6lu-0001XV-D3@rmk-PC.arm.linux.org.uk>
 <20111117172858.GA9581@n2100.arm.linux.org.uk>
Message-ID: <20111124064517.GE795@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 05:28:58PM +0000, Russell King - ARM Linux wrote:

> Ack?
> 
> On Sun, Nov 06, 2011 at 05:44:42PM +0000, Russell King - ARM Linux wrote:
> > Hook these platforms restart code into the arm_pm_restart hook rather
> > than using arch_reset().
> > 
> > In doing so, we split out the n2100 platform specific restart handler
> > into the n2100 platform file.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Lennert Buytenhek <buytenh@wantstofly.org>
