From: davem@davemloft.net (David Miller)
Date: Thu, 08 May 2014 22:42:52 -0400 (EDT)
Subject: [PATCH] netdev: add support for interface name retrieval from
 DT aliases
In-Reply-To: <1399390594-1409-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1399390594-1409-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140508.224252.1337086843732451389.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Date: Tue,  6 May 2014 17:36:34 +0200

> There is currently no proper way to bind a net interface to a specific
> name. The interface name is chosen based on the interface type (eth,
> wlan, ...) and the interfaces already registered (the core codes takes
> the first unused interface id of the given type).
> 
> Add support for DT retrieval of the interface id based on DT aliases.
> The alias name must match the interface type (e.g. ethX if you're defining
> an ethernet dev alias).
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

This really isn't kosher at all.

And there absolutely is a proper way to bind a net interface to
a specific name, udev has provided this facility for years.

I'm not applying this, sorry.
