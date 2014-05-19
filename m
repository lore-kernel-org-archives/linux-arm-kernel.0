From: carlo@caione.org (Carlo Caione)
Date: Mon, 19 May 2014 10:36:50 +0200
Subject: [linux-sunxi] [PATCH] regulator: AXP20x: fix wrong call to
 of_find_node_by_name
In-Reply-To: <1400487930-22949-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1400487930-22949-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <CAOQ7t2Y9NCHG_nWoXMDXqZe+iBtxX+AnCUUWptKCgJ6O6e+j+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 10:25 AM, Boris BREZILLON
<boris.brezillon@free-electrons.com> wrote:
> The of_find_node_by_name function will search for a DT node named
> "regulators" after the provided np node, but will not ensure that this node
> is a child of np.
> This might result in retrieving a "regulators" node that is not related to
> the axp20x PMIC.
>
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---

Acked-by: Carlo Caione <carlo@caione.org>

Thank you,

-- 
Carlo Caione
