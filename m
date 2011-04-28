From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Apr 2011 09:27:39 +0100
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <11431.1303949729@localhost>
References: <201104212129.17013.arnd@arndb.de>
	<BANLkTinPbZZS9F1tRCA73fgoD-y__jSfCA@mail.gmail.com>
	<201104271243.16868.arnd@arndb.de>
	<1303902508.15101.21.camel@e102109-lin.cambridge.arm.com>
	<11431.1303949729@localhost>
Message-ID: <1303979259.26744.3.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-04-28 at 01:15 +0100, Valdis.Kletnieks at vt.edu wrote:
> On Wed, 27 Apr 2011 12:08:28 BST, Catalin Marinas said:
> 
> > The current version of the ARM ARM says "unpredictable". But this
> > general definition of "unpredictable" does not allow it to deadlock
> > (hardware) or have security implications. It is however allowed to
> > corrupt data.
> 
> Not allowed to have security implications, but is allowed to corrupt data.

By security I was referring to TrustZone extensions. IOW, unpredictable
in normal (non-secure) world should not cause data corruption in the
secure world.

-- 
Catalin
