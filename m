From: tony@atomide.com (Tony Lindgren)
Date: Thu, 7 Jul 2011 12:08:39 -0700
Subject: [RFC 02/12] omap: mcbsp: Remove rx_/tx_word_length variables
In-Reply-To: <1309510356-27147-3-git-send-email-jhnikula@gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
	<1309510356-27147-3-git-send-email-jhnikula@gmail.com>
Message-ID: <20110707190838.GO5783@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jarkko Nikula <jhnikula@gmail.com> [110701 01:48]:
> These variables got unused after ("omap: mcbsp: Drop in-driver transfer
> support") but was noticed only afterwards.

I'll queue this and the one after this into cleanup.

Regards,

Tony
