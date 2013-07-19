From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Jul 2013 15:56:35 +0100
Subject: alignment handler instruction endian-ness
In-Reply-To: <51E95224.9010306@codethink.co.uk>
References: <51E91BE5.8070809@codethink.co.uk>
 <20130719110947.GD24642@n2100.arm.linux.org.uk>
 <1374242462.3406.59.camel@linaro1.home>
 <20130719140513.GF24642@n2100.arm.linux.org.uk>
 <51E95224.9010306@codethink.co.uk>
Message-ID: <20130719145634.GH24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 03:50:12PM +0100, Ben Dooks wrote:
> Should we use __mem_to_opcode_arm() in the aligned and abort
> handlers?

I think so.
