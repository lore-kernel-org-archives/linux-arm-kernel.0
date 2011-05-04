From: davem@davemloft.net (David Miller)
Date: Tue, 03 May 2011 23:12:55 -0700 (PDT)
Subject: [PATCH] atomic: add *_dec_not_zero
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
Message-ID: <20110503.231255.115931602.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  3 May 2011 23:30:35 +0200

> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.
> 
> Reported-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: David S. Miller <davem@davemloft.net>
