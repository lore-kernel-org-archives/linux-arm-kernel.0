From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 May 2014 17:40:17 +0100
Subject: [PATCH] regulator: AXP20x: fix wrong call to of_find_node_by_name
In-Reply-To: <1400487930-22949-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1400487930-22949-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140519164017.GG12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 10:25:30AM +0200, Boris BREZILLON wrote:
> The of_find_node_by_name function will search for a DT node named
> "regulators" after the provided np node, but will not ensure that this node
> is a child of np.
> This might result in retrieving a "regulators" node that is not related to
> the axp20x PMIC.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140519/cbfc57cd/attachment.sig>
