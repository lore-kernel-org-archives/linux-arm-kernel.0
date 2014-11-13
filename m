From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Nov 2014 17:40:41 +0100
Subject: [PATCH] dmaengine: at_xdmac: Declare slave capabilities for the
 generic code
In-Reply-To: <1415891480-9563-1-git-send-email-ludovic.desroches@atmel.com>
References: <1415888096-22090-1-git-send-email-ludovic.desroches@atmel.com>
 <1415891480-9563-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20141113164041.GK20972@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 04:11:20PM +0100, Ludovic Desroches wrote:
> Now that the generic slave caps code can make use of the device assigned
> capabilities, instead of relying on a callback to be implemented.
> 
> Make use of this code.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Merged into my serie, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/d653425b/attachment.sig>
