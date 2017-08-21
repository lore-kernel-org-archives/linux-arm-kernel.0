From: kubakici@wp.pl (Jakub Kicinski)
Date: Mon, 21 Aug 2017 15:25:15 -0700
Subject: [PATCH v2] mt7601u: check memory allocation failure
In-Reply-To: <20170821220617.21513-1-christophe.jaillet@wanadoo.fr>
References: <20170821220617.21513-1-christophe.jaillet@wanadoo.fr>
Message-ID: <20170821152515.717a4681@cakuba.netronome.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Aug 2017 00:06:17 +0200, Christophe JAILLET wrote:
> Check memory allocation failure and return -ENOMEM in such a case, as
> already done a few lines below.
> 
> As 'dev->tx_q' can be NULL, we also need to check for that in
> 'mt7601u_free_tx()', and return early.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Jakub Kicinski <kubakici@wp.pl>
