From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Fri, 4 Oct 2013 08:27:59 -0500
Subject: [PATCH 1/2] net: ethernet: cpsw: Search childs for slave nodes
In-Reply-To: <1380890680-30941-1-git-send-email-mpa@pengutronix.de>
References: <1380890680-30941-1-git-send-email-mpa@pengutronix.de>
Message-ID: <524EC25F.70301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 October 2013 07:44 AM, Markus Pargmann wrote:
> The current implementation searches the whole DT for nodes named
> "slave".
>
> This patch changes it to search only child nodes for slaves.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Acked-by: Mugunthan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N
