From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Sat, 12 Jun 2010 10:29:19 +0200
Subject: [PATCH] Marvell OpenRD-Ultimate machine support
In-Reply-To: <4c1139ba.0d01df0a.42a6.1368@mx.google.com>
References: <4c1139ba.0d01df0a.42a6.1368@mx.google.com>
Message-ID: <20100612082919.GN1743@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 10, 2010 at 10:12:55PM +0300, Dmytro Milinevskyy wrote:

> This patch adds support for the OpenRD Ultimate machine(could be found at http://www.arm.linux.org.uk/developer/machines/list.php?id=2884)

Acked-by: Lennert Buytenhek <buytenh@wantstofly.org>


> +MACHINE_START(OPENRD_ULTIMATE, "Marvell OpenRD Ultimate Board")
> +	/* Maintainer: Dhaval Vasa <dhaval.vasa@einfochips.com> */

I wonder whether this is correct, though.
