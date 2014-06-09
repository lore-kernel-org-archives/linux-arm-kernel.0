From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 09 Jun 2014 10:32:57 +0100
Subject: [PATCH] ARM: shmobile: lager: Remove duplicate i2c3 nodes
In-Reply-To: <1402279784-5587-1-git-send-email-horms+renesas@verge.net.au>
References: <1402279784-5587-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <53957F49.40905@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/14 03:09, Simon Horman wrote:
> Due to an error when merging df40f256b18300e1 ("ARM: shmobile:
> lager: add i2c1, i2c2 pins") a duplicate i2c3 node.
> 
> This patch moves the duplicate and moves to old node to
> be closer to the other new i2c nodes.
> 
> Cc: Ben Dooks <ben.dooks@codethink.co.uk>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Ben Dooks <ben.dooks@codethink.co.uk>

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
