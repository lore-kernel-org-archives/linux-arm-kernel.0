From: balbi@ti.com (Felipe Balbi)
Date: Wed, 31 Aug 2011 11:57:27 +0300
Subject: [PATCH] musb_debugfs.c: remove unneeded includes on ARM
In-Reply-To: <alpine.LFD.2.00.1108301659540.20358@xanadu.home>
References: <alpine.LFD.2.00.1108301659540.20358@xanadu.home>
Message-ID: <20110831085726.GB28519@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2011 at 05:05:31PM -0400, Nicolas Pitre wrote:
> Nothing actually requires that <mach/hardware.h>, <mach/memory.h> nor
> <asm/mach-types.h> be included here.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Here you go:

Acked-by: Felipe Balbi <balbi@ti.com>

> I'd need appropriate ACK's as this is part of a cleanup series actually 
> removing <mach/memory.h>.  If those includes are not useless as I think 
> they are, an alternative solution will need to be found.
> Thanks.

thanks for doing this, there's still lots to cleanup on that driver and
whatever help is greatly apreciated.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110831/1f9e932c/attachment.sig>
