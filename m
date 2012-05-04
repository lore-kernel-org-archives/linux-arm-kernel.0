From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 21:05:58 +0000
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <20120504204207.GA11715@async.com.br>
References: <201205031350.35476.arnd@arndb.de>
 <CACRpkdZ3m=PXg35==3wo2xHPL7TRn1W0AX_CeMKjPd1U+pTAGQ@mail.gmail.com>
 <20120504204207.GA11715@async.com.br>
Message-ID: <201205042105.58459.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 May 2012, Christian Robottom Reis wrote:
> Isn't there work by Pawel that adds support for more of the Versatile
> platform? My quick searching finds at least:
> 
>     http://comments.gmane.org/gmane.linux.drivers.i2c/10143
>     http://comments.gmane.org/gmane.linux.ports.arm.kernel/143523
> 
> I think the latter is merged already, but I may be wrong.

That work was done for versatile express, which is very different
from versatile, although it shares a few devices like the i2c controller
mentioned in the first link.

	Arnd
