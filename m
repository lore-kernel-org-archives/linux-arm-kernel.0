From: kubakici@wp.pl (Jakub Kicinski)
Date: Mon, 21 Aug 2017 14:34:30 -0700
Subject: [PATCH] mt7601u: check memory allocation failure
In-Reply-To: <20170821205956.20859-1-christophe.jaillet@wanadoo.fr>
References: <20170821205956.20859-1-christophe.jaillet@wanadoo.fr>
Message-ID: <20170821143430.635e4b92@cakuba.netronome.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Aug 2017 22:59:56 +0200, Christophe JAILLET wrote:
> Check memory allocation failure and return -ENOMEM in such a case, as
> already done a few lines below
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Jakub Kicinski <kubakici@wp.pl>

Thanks!
