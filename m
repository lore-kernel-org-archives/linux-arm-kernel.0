From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 27 May 2013 19:39:25 +1000
Subject: [PATCH 1/2] ARM: kirkwood: proper retain MAC address workaround
 on DT ethernet
In-Reply-To: <20130527.022339.791886107453761860.davem@davemloft.net>
References: <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130525.210441.818472895703230779.davem@davemloft.net>
 <51A26B62.4050009@gmail.com>
 <20130527.022339.791886107453761860.davem@davemloft.net>
Message-ID: <1369647565.3557.28.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-05-27 at 02:23 -0700, David Miller wrote:
> Sparc has an of_set_property(), it needs to become generic.

There is an of_update_property(), we could change the name though, yours
is nicer :-)

Cheers,
Ben.
