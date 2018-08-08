From: davem@davemloft.net (David Miller)
Date: Tue, 07 Aug 2018 17:59:31 -0700 (PDT)
Subject: [PATCH 00/33] net: ethernet: Mark expected switch fall-throughs
In-Reply-To: <cover.1533675546.git.gustavo@embeddedor.com>
References: <cover.1533675546.git.gustavo@embeddedor.com>
Message-ID: <20180807.175931.200772329178253653.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 7 Aug 2018 18:09:00 -0500

> In preparation to enabling -Wimplicit-fallthrough, this patchset aims
> to add some annotations in order to mark switch cases where we are
> expecting to fall through.

Ok, I went through all of these and they look good.

If any are not correct we can revert/fix.

Series applied, thanks.
