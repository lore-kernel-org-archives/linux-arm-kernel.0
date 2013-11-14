From: sre@debian.org (Sebastian Reichel)
Date: Thu, 14 Nov 2013 23:03:33 +0000
Subject: [PATCH 1/4] wl1251: split wl251 platform data to a separate
 structure
In-Reply-To: <20131114185132.GQ10317@atomide.com>
References: <1382890469-25286-1-git-send-email-sre@debian.org>
 <1382890469-25286-2-git-send-email-sre@debian.org>
 <20131114185132.GQ10317@atomide.com>
Message-ID: <20131114230330.GB6383@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 10:51:33AM -0800, Tony Lindgren wrote:
> [...]
>
> If this is not going into v3.13, these will cause conflicts
> with the mach-omap2/board-*.c files for v3.14.
> 
> So it might be best to do a minimal header patch first that
> can be merged in by both linux-omap and wireless trees.

I guess this patch is pretty minimal. It also seems to be acked by
the involved Maintainers, so maybe just merge Patch 1 without the
other patches?

This does not solve the problem with the struct modification from
the second patch, but I guess it's the more intrusive patch.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131114/6203cf0b/attachment.sig>
