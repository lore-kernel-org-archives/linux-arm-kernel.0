From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 22 Jul 2013 14:31:00 -0400 (EDT)
Subject: alignment handler instruction endian-ness
In-Reply-To: <51E93CD0.3040302@codethink.co.uk>
References: <51E91BE5.8070809@codethink.co.uk>
 <20130719110947.GD24642@n2100.arm.linux.org.uk>
 <51E92DE5.6090404@codethink.co.uk>
 <20130719123249.GE24642@n2100.arm.linux.org.uk>
 <51E93CD0.3040302@codethink.co.uk>
Message-ID: <alpine.LFD.2.03.1307221428050.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Jul 2013, Ben Dooks wrote:
> On 19/07/13 13:32, Russell King - ARM Linux wrote:
> > If you value your soul, NEVER EVER EVER place stuff which is not part
> > of the user API in a header file in a UAPI subdirectory.  And never
> > modify a header file in a UAPI subdirectory without first having a
> > good long think about how that modification may impact _userspace_.
> 
> Sorry, searched for byteorder.h and just did not notice.
> 
> Where is the best place for these to go?

You should really have a look at arch/arm/include/asm/opcodes.h.


Nicolas
