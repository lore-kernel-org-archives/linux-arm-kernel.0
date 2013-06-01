From: davem@davemloft.net (David Miller)
Date: Fri, 31 May 2013 17:23:36 -0700 (PDT)
Subject: [PATCHv4 0/6] ARM: sunxi: Add support for A10 Ethernet controller
In-Reply-To: <1369921765-3367-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1369921765-3367-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130531.172336.1848458955586893446.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 30 May 2013 15:49:19 +0200

> The Allwinner A10 SoC has an ethernet controller that seem to be specific to
> Allwinner. This IP has no public documentation, so exact
> details are quite sparse, and this code come from refactored Allwinner
> code.
> 
> The rework to use NAPI is taking more time than expected, I'm still working
> on it, but it could probably be sent as a follow-up patch.

Looks good.

All applied to net-next, thanks.
