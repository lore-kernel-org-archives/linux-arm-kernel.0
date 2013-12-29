From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 29 Dec 2013 23:36:57 +0100
Subject: [PATCH 2/2] ARM: sun4i: dt: Remove chosen nodes
In-Reply-To: <1387576387-22122-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1387576387-22122-1-git-send-email-maxime.ripard@free-electrons.com>
 <1387576387-22122-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20131229223657.GQ3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 10:53:07PM +0100, Maxime Ripard wrote:
> The chosen nodes are nowadays pretty useless, since they will be overriden by
> the bootloader anyway.
> 
> We can thus safely remove them.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Merged in sunxi/dt-for-3.14

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131229/3e599f19/attachment-0001.sig>
