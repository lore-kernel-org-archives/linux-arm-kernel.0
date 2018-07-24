From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Jul 2018 15:00:35 +0200
Subject: [PATCH v2 4/5] nvmem: sunxi-sid: add support for H5's SID
 controller
In-Reply-To: <20180724101522.68165-4-manu@freebsd.org>
References: <20180724101522.68165-1-manu@freebsd.org>
 <20180724101522.68165-4-manu@freebsd.org>
Message-ID: <20180724130035.cll6mdqiqjbglotj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 12:15:21PM +0200, Emmanuel Vadot wrote:
> The H5 SoC have a SID controller that looks like the one in A64, but
> in case we find some difference in the futur at a binding for it.
> 
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>

The prefix in your commit title should start with dt-bindings: ...

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/8b6f6fc4/attachment.sig>
