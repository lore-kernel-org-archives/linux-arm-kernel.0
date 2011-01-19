From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 19 Jan 2011 10:41:32 -0500 (EST)
Subject: RFC: Host-endian device tree format
In-Reply-To: <AANLkTi=xdJ_c3LvCFkeqBRNDf6TSC40Fjxihm9eSeMmf@mail.gmail.com>
References: <AANLkTi=AdwaW5vvm1TzNxcNrjYiJ3dOEjwoZrm-koxuw@mail.gmail.com>
	<AANLkTikoZj1WSpE8QNSRiF3oFL4qAb68kNnCKdExvBz7@mail.gmail.com>
	<AANLkTi=xdJ_c3LvCFkeqBRNDf6TSC40Fjxihm9eSeMmf@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1101191031481.8580@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Jan 2011, Dave Martin wrote:
> On Wed, Jan 19, 2011 at 1:41 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > The dtb isn't so much bigendian as it is network byte order.
> 
> (For me, "network byte order" is a euphemism ... <insert
> unconstructive rant here>)

I concur.

> However I digress... it sounds like you are familiar with the
> arguments I would make, and I'm not trying to get into an endianness
> war ;)

I think this is the same issue as for filesystems.  Having different 
endianness in use might only lead to confusion when a piece of data can 
be externally provided.  And since DT was created on PPC first then that 
naturally decided on the endianness for it.


Nicolas
