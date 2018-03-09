From: davem@davemloft.net (David Miller)
Date: Fri, 09 Mar 2018 12:00:25 -0500 (EST)
Subject: [PATCH] net: ethernet: ave: enable Rx drop interrupt
In-Reply-To: <1520576840-17566-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1520576840-17566-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <20180309.120025.876982305242341526.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Fri,  9 Mar 2018 15:27:20 +0900

> This enables AVE_GI_RXDROP interrupt factor. This factor indicates
> depletion of Rx descriptors and the handler counts the number
> of dropped packets.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Applied, thank you.
