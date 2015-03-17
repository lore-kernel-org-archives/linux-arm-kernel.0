From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 17 Mar 2015 12:00:00 +0100
Subject: [PATCH 3/3] ARM: omap2plus_defconfig: Enable n900 modem as
 loadable modules
In-Reply-To: <1426536003-7077-4-git-send-email-tony@atomide.com>
References: <1426536003-7077-1-git-send-email-tony@atomide.com>
 <1426536003-7077-4-git-send-email-tony@atomide.com>
Message-ID: <20150317110000.GA1115@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Mon, Mar 16, 2015 at 01:00:03PM -0700, Tony Lindgren wrote:
> Enable n900 modem as loadable modules.

Acked-By: Sebastian Reichel <sre@kernel.org>

> [...]
> +CONFIG_HSI_CHAR=m
> [...]

I think this one should be disabled by default. It's only needed by
very few people (it exposes the hsi bus to userspace, like i2c-dev
driver does for i2c).

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150317/28121816/attachment-0001.sig>
