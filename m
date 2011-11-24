From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Thu, 24 Nov 2011 07:46:11 +0100
Subject: [PATCH 17/41] ARM: restart: ixp23xx: use new restart hook
In-Reply-To: <20111117173002.GD9581@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6mt-0001Xh-QL@rmk-PC.arm.linux.org.uk>
 <20111117173002.GD9581@n2100.arm.linux.org.uk>
Message-ID: <20111124064611.GH795@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 05:30:03PM +0000, Russell King - ARM Linux wrote:

> Ack?
> 
> On Sun, Nov 06, 2011 at 05:45:43PM +0000, Russell King - ARM Linux wrote:
> > Hook these platforms restart code into the new restart hook rather
> > than using arch_reset().
> > 
> > In doing so, we split out the ixdp2351 restart code into its own
> > platform file.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Lennert Buytenhek <buytenh@wantstofly.org>
