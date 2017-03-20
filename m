From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Mar 2017 09:59:52 +0100
Subject: [PATCH] mmc: sunxi: change controller error info to debug level
In-Reply-To: <20170316132903.61246-1-icenowy@aosc.xyz>
References: <20170316132903.61246-1-icenowy@aosc.xyz>
Message-ID: <20170320085952.dodqzbj7bvvggke6@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 09:29:03PM +0800, Icenowy Zheng wrote:
> The controller's errors are usually normal (for example, for MMC or SDIO
> cards, some errors are expected to happen; and for boards without a
> dedicated card detect pin the error info will even flood console and
> hide other normal messages) and hard to understand.
> 
> Change their print level to debug, thus it won't be shown to generic
> users.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/c10080f5/attachment.sig>
