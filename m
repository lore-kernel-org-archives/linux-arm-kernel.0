From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Apr 2014 15:11:42 +0200
Subject: [PATCH v6 6/8] ARM: sun6i: Sort the NMI node by physical address
In-Reply-To: <201404231439.26549.arnd@arndb.de>
References: <1397724379-15398-1-git-send-email-maxime.ripard@free-electrons.com>
 <1397724379-15398-7-git-send-email-maxime.ripard@free-electrons.com>
 <201404231439.26549.arnd@arndb.de>
Message-ID: <20140423131142.GR24905@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 02:39:26PM +0200, Arnd Bergmann wrote:
> On Thursday 17 April 2014, Maxime Ripard wrote:
> > The DT are supposed to be ordered by physical address. Move the NMI node where
> > it belongs.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

Just applied.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140423/00f8a0d9/attachment.sig>
