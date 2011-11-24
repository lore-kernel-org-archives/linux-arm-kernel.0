From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Thu, 24 Nov 2011 07:45:47 +0100
Subject: [PATCH 16/41] ARM: restart: ixp2000: use new restart hook
In-Reply-To: <20111117172940.GC9581@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6mZ-0001Xd-9V@rmk-PC.arm.linux.org.uk>
 <20111117172940.GC9581@n2100.arm.linux.org.uk>
Message-ID: <20111124064547.GG795@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 05:29:40PM +0000, Russell King - ARM Linux wrote:

> Ack?
> 
> On Sun, Nov 06, 2011 at 05:45:23PM +0000, Russell King - ARM Linux wrote:
> > Hook these platforms restart code into the new restart hook rather
> > than using arch_reset().
> > 
> > In doing so, we split out the IXDP2401, IXDP2801 and IXDP2805 platform
> > specific restart code into their own platform files.

Acked-by: Lennert Buytenhek <buytenh@wantstofly.org>
