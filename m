From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Apr 2010 22:05:21 +0100
Subject: [RFC 09/10] arm: implement reserve memory early parameter
In-Reply-To: <9c79bfd3046abe3165a79b6ef10c1938c455fa71.1269854500.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<9c79bfd3046abe3165a79b6ef10c1938c455fa71.1269854500.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <20100412210521.GW3048@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 29, 2010 at 12:26:35PM +0300, Mika Westerberg wrote:
> Implemented mem=size$start early parameter which makes it possible to reserve
> some memory from the kernel. This can be used for dump capture kernels to
> preserve any memory used by the primary kernel.

Please note that if we move ARM over to LMB, these patches will have to
be redone.

However, I'm not sure why this is required - it appears that x86 doesn't
require this kind of feature.  Can you explain in more detail how this
new parameter format would be used?
