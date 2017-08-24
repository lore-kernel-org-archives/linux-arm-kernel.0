From: kvalo@codeaurora.org (Kalle Valo)
Date: Thu, 24 Aug 2017 09:55:46 +0000 (UTC)
Subject: [v2] mt7601u: check memory allocation failure
In-Reply-To: <20170821220617.21513-1-christophe.jaillet@wanadoo.fr>
References: <20170821220617.21513-1-christophe.jaillet@wanadoo.fr>
Message-ID: <20170824095546.9DE6C602B3@smtp.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christophe Jaillet <christophe.jaillet@wanadoo.fr> wrote:

> Check memory allocation failure and return -ENOMEM in such a case, as
> already done a few lines below.
> 
> As 'dev->tx_q' can be NULL, we also need to check for that in
> 'mt7601u_free_tx()', and return early.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Acked-by: Jakub Kicinski <kubakici@wp.pl>

Patch applied to wireless-drivers-next.git, thanks.

b3b2f62c6238 mt7601u: check memory allocation failure

-- 
https://patchwork.kernel.org/patch/9913855/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
