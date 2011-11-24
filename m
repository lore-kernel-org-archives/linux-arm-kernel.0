From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Thu, 24 Nov 2011 07:45:28 +0100
Subject: [PATCH 15/41] ARM: restart: iop13xx: use new restart hook
In-Reply-To: <20111117172919.GB9581@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6mE-0001XZ-RX@rmk-PC.arm.linux.org.uk>
 <20111117172919.GB9581@n2100.arm.linux.org.uk>
Message-ID: <20111124064528.GF795@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 05:29:19PM +0000, Russell King - ARM Linux wrote:

> Ack?
> 
> On Sun, Nov 06, 2011 at 05:45:02PM +0000, Russell King - ARM Linux wrote:
> > Hook these platforms restart code into the new restart hook rather
> > than using arch_reset().

Acked-by: Lennert Buytenhek <buytenh@wantstofly.org>
