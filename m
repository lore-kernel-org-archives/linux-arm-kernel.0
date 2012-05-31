From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 May 2012 20:40:33 +0000
Subject: ARM Versatile defconfig PCI io out of range?
In-Reply-To: <4FC76D0A.9060009@gmail.com>
References: <20120530180242.GA15772@codethink.co.uk>
 <201205310932.51140.arnd@arndb.de> <4FC76D0A.9060009@gmail.com>
Message-ID: <201205312040.34382.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 May 2012, Rob Herring wrote:
> I've resurrected your patch from ~2 years ago and that does fix it. Any
> reason it was never merged? I could go with a more simple fix which just
> restore IO_SPACE_LIMIT to ~0, but yours is more in the direction we want
> to go with PCI mappings.

It was only my fault for not pushing the patches enough. I think they should
really go in now. 

	Arnd
