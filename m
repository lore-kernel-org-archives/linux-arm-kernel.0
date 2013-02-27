From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 27 Feb 2013 12:52:19 -0500 (EST)
Subject: [RFC PATCH v2 0/4] Add support for LZ4-compressed kernel
In-Reply-To: <1361986787.20540.8.camel@joe-AO722>
References: <1361859870-15751-1-git-send-email-kyungsik.lee@lge.com>
 <512D1C12.4080109@oberhumer.com>
 <alpine.LFD.2.03.1302261557220.1254@syhkavp.arg>
 <87fw0i7n6d.fsf@dell.be.48ers.dk>
 <20130226221027.GW17833@n2100.arm.linux.org.uk>
 <1361929234.1924.8.camel@joe-AO722>
 <20130227095609.GY17833@n2100.arm.linux.org.uk>
 <1361980152.2035.13.camel@joe-AO722>
 <20130227163118.GB17833@n2100.arm.linux.org.uk>
 <1361984688.2035.20.camel@joe-AO722>
 <alpine.LFD.2.03.1302271211360.1254@syhkavp.arg>
 <1361986787.20540.8.camel@joe-AO722>
Message-ID: <alpine.LFD.2.03.1302271246440.1254@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Feb 2013, Joe Perches wrote:

> On Wed, 2013-02-27 at 12:16 -0500, Nicolas Pitre wrote:
> > RMK says that "66% increase in decompression speed over LZO" is 
> > significant.  You apparently disagree with that.
> 
> Yeah, I can see how that can be interpreted.
> I'm referring only to the new LZO.
> 
> I guess Russell has not reviewed the new LZO.
> 
> There is apparently no speed increase for LZ4 over
> the new LZO.
> 
> I believe Markus has shown comparison testing in
> this very thread.
> 
> https://patchwork.kernel.org/patch/2187441/

Right.

Can the new LZO code be merged by Linus now?  It has been sitting in 
linux-next for quite some time.  Afterwards we could revisit lz4 
worthiness without all the present confusion.

BTW, I still wonder what that patch requiring ARM people approval is.


Nicolas
