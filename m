From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 10:44:18 +0100
Subject: [PATCH v2] arm: use addruart macro to establish debug mappings
In-Reply-To: <1279702980.221230.84864205444.1.gpush@pororo>
References: <1279702980.221230.84864205444.1.gpush@pororo>
Message-ID: <20100722094418.GA31293@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 21, 2010 at 11:03:00AM +0200, Jeremy Kerr wrote:
> Since we can call addruart with an argument to specify that we want a
> physical or virtual address, use addruart in the debug mapping code to
> find these addresses.

I think you need to update the changelog above.  We no longer call
addruart with any arguments, other than what registers we'd like the
virtual and physical addresses in.

Apart from that, I'm happy with this patch.
