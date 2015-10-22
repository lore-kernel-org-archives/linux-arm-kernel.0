From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 Oct 2015 09:58:35 +0200
Subject: [PATCH 4/6] reset: sunxi: Add compatible for Allwinner H3 bus
 resets
In-Reply-To: <1445444428-4652-1-git-send-email-jenskuske@gmail.com>
References: <1445444428-4652-1-git-send-email-jenskuske@gmail.com>
Message-ID: <20151022075835.GM10947@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 06:20:26PM +0200, Jens Kuske wrote:
> Adding a new compatible allows us to define SoC specific behaviour
> if necessary, for example forcing a particular device out of reset
> even if no driver is actually using it.
> 
> Signed-off-by: Jens Kuske <jenskuske@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151022/dbdb81b3/attachment.sig>
