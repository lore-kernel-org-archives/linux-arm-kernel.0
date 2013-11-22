From: sre@ring0.de (Sebastian Reichel)
Date: Fri, 22 Nov 2013 17:35:33 +0100
Subject: [PATCH 3/3] ARM: OMAP2+: Fix eMMC on n900 with device tree
In-Reply-To: <20131121235729.GD10023@atomide.com>
References: <1385059866-10646-1-git-send-email-tony@atomide.com>
 <1385059866-10646-4-git-send-email-tony@atomide.com>
 <20131121231751.GA9772@earth.universe>
 <20131121235729.GD10023@atomide.com>
Message-ID: <20131122163532.GA32331@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 03:57:29PM -0800, Tony Lindgren wrote:
> Well let's use just vaux3 then with a comment to the .dts file if that
> works also on your 0x2204. It works on my 0x0010 too.
> 
> I folded in your changes to the updated patch below. Care to reply with
> your Signed-off-by too assuming it works also on your 0x2204 n900?

It does work with the 0x2204 phone.

Signed-off-by: Sebastian Reichel <sre@debian.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131122/f13c7aaf/attachment.sig>
