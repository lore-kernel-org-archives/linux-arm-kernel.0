From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 26 Aug 2013 16:45:23 -0400
Subject: [PATCH v4 0/3] arm: mvebu: fix resource leak
In-Reply-To: <1377517018-7716-1-git-send-email-jszhang@marvell.com>
References: <1377517018-7716-1-git-send-email-jszhang@marvell.com>
Message-ID: <20130826204523.GD24470@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 07:36:55PM +0800, Jisheng Zhang wrote:
> These patches try to fix resource leak by adding missing of_node_put(),
> iounmap or using devm_ioremap_resource() if available.
> 
> v4:
>   - re-generate since Ezequiel's patches add DT support to the
> mvebu-mbus driver

grrr.  I hate to ask this, but can you please rebase patches 1 and 2
against mvebu/fixes-non-critical?  No need to add back in the mvebu-mbus
hunk.

thx,

Jason.
